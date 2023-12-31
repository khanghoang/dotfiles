return {
  "junegunn/fzf",
  {
    "junegunn/fzf.vim",
    build = function()
      vim.fn["fzf#install"]()
    end,
    config = function()
      local g = vim.g
      local api = vim.api

      g.fzf_history_dir = "~/.local/share/fzf-history"

      vim.cmd(
        [[command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case --hidden -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)]]
      )

      -- api.nvim_set_keymap('n', '<leader><space>', ':FZFMru<CR>', { noremap = true })
      -- api.nvim_set_keymap('n', '<leader>f', ':History<CR>', { noremap = true })
      -- api.nvim_set_keymap('n', '<leader>fg', ':Rg!<CR>', {noremap = true})
      -- api.nvim_set_keymap('n', '<leader>fb', ':Buffers!<CR>', {noremap = true})
      -- api.nvim_set_keymap('n', '<leader>fw', ':Rg!<C-R><C-W><CR>', {noremap = true})

      vim.cmd([[
          command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})
        ]])
      vim.cmd([[
        function! s:tags_sink(line)
          let parts = split(a:line, '\t\zs')
          let excmd = matchstr(parts[2:], '^.*\ze;"\t')
          execute 'silent e' parts[1][:-2]
          let [magic, &magic] = [&magic, 0]
          execute excmd
          let &magic = magic
        endfunction

        function! s:tags()
          if empty(tagfiles())
            echohl WarningMsg
            echom 'Preparing tags'
            echohl None
            call system('ctags -R')
          endif

          call fzf#run({
          \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
          \            '| grep -v -a ^!',
          \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
          \ 'down':    '40%',
          \ 'sink':    function('s:tags_sink')})
        endfunction

        command! Tags call s:tags()
        ]])
      vim.cmd([[
      function! s:ag_to_qf(line)
        let parts = split(a:line, ':')
        return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
              \ 'text': join(parts[3:], ':')}
      endfunction

      function! s:ag_handler(lines)
        if len(a:lines) < 2 | return | endif

        let cmd = get({'ctrl-x': 'split',
                     \ 'ctrl-v': 'vertical split',
                     \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
        let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

        let first = list[0]
        execute cmd escape(first.filename, ' %#\')
        execute first.lnum
        execute 'normal!' first.col.'|zz'

        if len(list) > 1
          call setqflist(list)
          copen
          wincmd p
        endif
      endfunction

      command! -nargs=* Ag call fzf#run({
      \ 'source':  printf('ag --nogroup --column --color "%s"',
      \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
      \ 'sink*':    function('<sid>ag_handler'),
      \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
      \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
      \            '--color hl:68,hl+:110',
      \ 'down':    '50%'
      \ })
      ]])

      -- api.nvim_set_keymap('n', '<leader>p', '<leader>ff', {noremap = false})
      -- api.nvim_set_keymap('n', '<leader>s', '<leader>fg', {noremap = false})
      -- api.nvim_set_keymap('n', '<leader>b', '<leader>fb', {noremap = false})
      -- api.nvim_set_keymap('n', '<leader>w', '<leader>fw', {noremap = false})
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local actions = require("fzf-lua.actions")
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        winopts = {
          -- split = "belowright 25new",
          height = 0.4,
          width = 1,
          row = 1,
          column = 0,
          border = { " ", "─", " ", " ", " ", " ", " ", " " },
          preview = {
            hidden = "hidden",
            border = "border",
            title = false,
            layout = "horizontal",
            horizontal = "right:50%",
          },
        },
        keymap = {
          builtin = {
            ["ctrl-/"] = "toggle-preview",
          },
        },
        actions = {
          -- These override the default tables completely
          -- no need to set to `false` to disable an action
          -- delete or modify is sufficient
          files = {
            -- providers that inherit these actions:
            --   files, git_files, git_status, grep, lsp
            --   oldfiles, quickfix, loclist, tags, btags
            --   args
            -- default action opens a single selection
            -- or sends multiple selection to quickfix
            -- replace the default action with the below
            -- to open all files whether single or multiple
            -- ["default"]     = actions.file_edit,
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-l"] = actions.file_sel_to_ll,
          },
          buffers = {
            -- providers that inherit these actions:
            --   buffers, tabs, lines, blines
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          },
        },
        fzf_opts = {
          -- options are sent as `<left>=<right>`
          -- set to `false` to remove a flag
          -- set to '' for a non-value flag
          -- for raw args use `fzf_args` instead
          ["--ansi"] = "",
          ["--layout"] = "reverse-list",
          ["--border"] = "top",
        },
        grep = {
          actions = {
            -- actions inherit from 'actions.files' and merge
            -- this action toggles between 'grep' and 'live_grep'
            ["ctrl-f"] = { actions.grep_lgrep },
          },
        },
      })

      -- NOTE: need `fd`, `fre` installed
      local function fzf_mru(opts)
        local fzf_lua = require("fzf-lua")
        local git_root = fzf_lua.path.git_root(opts)
        -- Replace "/" with "\/"
        local modified_git_root = git_root:gsub("/", "\\/")
        -- local relative = fzf_lua.path.relative(vim.loop.cwd(), git_root)

        -- awk '!x[$0]++' to remove duplicated entries
        local cmd = string.format(
          "(fre --sorted --store_name '%s';rg --files) | awk '!x[$0]++'",
          modified_git_root
        )
        if not modified_git_root then
          cmd = string.format("rg --files")
        end

        require("fzf-lua").fzf_exec(cmd, {
          prompt = opts.args .. "> ",
          fzf_opts = vim.tbl_extend("force", {}, {
            ["--tiebreak"] = "index", -- make sure that items towards top are from history
          }),
          actions = {
            ["default"] = function(selected, o)
              local file = require("fzf-lua").path.entry_to_file(selected[1], o)
              if modified_git_root then
                local save_open_file_cmd =
                  string.format("fre --add --store_name '%s' %s", modified_git_root, file.path)
                os.execute(save_open_file_cmd)
              end
              local open_file = string.format("edit %s", file.path)
              vim.cmd(open_file)
            end,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-l"] = actions.file_sel_to_ll,
            ["ctrl-d"] = {
              fn = function(selected, o)
                local file = require("fzf-lua").path.entry_to_file(selected[1], o)
                if modified_git_root then
                  local save_open_file_cmd =
                    string.format("fre --delete --store_name '%s' %s", modified_git_root, file.path)
                  os.execute(save_open_file_cmd)
                end
              end,
              reload = true,
            },
            -- ["ctrl-s"] = false,
            -- ["ctrl-v"] = function(selected, o)
            --   local file = require("fzf-lua").path.entry_to_file(selected[1], o)
            --   local cmd = string.format("Gvsplit %s:%s", opts.args, file.path)
            --   vim.cmd(cmd)
            -- end,
          },
          -- previewer = false,
          -- preview = require("fzf-lua").shell.raw_preview_action_cmd(function(items)
          --   local file = require("fzf-lua").path.entry_to_file(items[1])
          --   return string.format("git diff %s HEAD -- %s | delta", opts.args, file.path)
          -- end),
        })
      end

      vim.api.nvim_create_user_command("FzfMru", fzf_mru, {})
      vim.api.nvim_set_keymap(
        "n",
        "<leader><space>",
        ":FzfMru<CR>",
        { noremap = true, silent = true, desc = "Git files" }
      )
    end,
  },
  keys = {
    {
      "st",
      "<cmd>FzfLua tabs<CR>",
      desc = "[S]earch [T]abs",
    },
    {
      "sb",
      "<cmd>FzfLua buffers<CR>",
      desc = "[S]earch [B]uffers",
    },
    {
      "gw",
      "<cmd>FzfLua grep_cword<CR>",
      desc = "[G]rep [W]ord",
    },
  },
}
