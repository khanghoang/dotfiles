return {
  -- load plugins in "/plugins" dir
  -- { import = "plugins" },

  -- Color schemes
  -- {{{
  "mhartington/oceanic-next",
  "frankier/neovim-colors-solarized-truecolor-only",
  -- }}}

  -- Navigation
  -- {{{
  "rbgrouleff/bclose.vim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
      })

      vim.api.nvim_set_keymap(
        "n",
        "<C-h>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-j>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-k>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-l>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-\\>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-Space>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>",
        { noremap = true, silent = true }
      )
    end,
  },
  -- }}}

  -- TreeSitter
  -- {{{

  -- run and display test results
  -- use {
  --   "rcarriga/neotest",
  --   -- "~/code/neotest",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     -- disable due to a weird error about duplicated function declaration
  --     "antoinemadec/FixCursorHold.nvim",
  --     "vim-test/vim-test",
  --     "rcarriga/neotest-vim-test",
  --     -- local dev
  --     -- '~/code/neotest-vim-test',
  --     "rcarriga/neotest-plenary",
  --   },
  --   config = function()
  --     local g = vim.g
  --     -- in millisecond, used for both CursorHold and CursorHoldI,
  --     -- use updatetime instead if not defined
  --     g.cursorhold_updatetime = 100
  --
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }),
  --         -- why do we need this???
  --         -- require("neotest-plenary")
  --       }
  --     })
  --
  --     -- disable for testing
  --     -- g["test#javascript#runner"] = 'jest'
  --     -- g["test#typescript#runner"] = 'jest'
  --     -- g["test#strategy"] = 'dispatch_background'
  --
  --     -- usage:
  --     -- 1. Run test (for example :TestNearest)
  --     -- 2. <C-o> to scroll through the test results
  --     -- 3. <C-o> on the failed test LOC to open it in vim
  --     vim.cmd [[tmap <C-o> <C-\><C-n>]]
  --
  --     vim.api.nvim_set_keymap('n', '<leader>tn', ":TestNearest<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tf', ":TestNearest<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>ts', ":TestNearest<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tl', ":TestLast<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tl', ":TestLast<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tr', ":lua require('neotest').run.run()<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tt', ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  --       { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>to', ":lua require('neotest').summary.open()<CR>", { noremap = true })
  --   end
  -- }

  -- }}}

  -- Filetypes
  -- {{{
  -- Generate table of content from a markdown file
  -- Mostly for Table of Content, zk is for another purpose
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
  },
  {
    "ellisonleao/glow.nvim",
    branch = "main",
    ft = { "markdown" },
  },
  -- }}}

  -- Misc
  --- {{{
  -- Written in Lua
  -- This plug-in provides automatic closing of quotes, parenthesis, brackets
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Usage:
  -- c      s               "      '
  -- ^      ^               ^      ^
  -- change surround` from `"` to `'`
  -- d      s          "
  -- ^      ^          ^
  -- delete surround` `"`
  --- Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by `S"`
  "tpope/vim-surround",

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  "christoomey/vim-tmux-navigator",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- find the matching characters for {}, [], etc
  -- https://github.com/andymass/vim-matchup#a2-jump-to-open-and-close-words
  { "andymass/vim-matchup", event = "VimEnter" },
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  -- support prisma schema
  {
    "pantharshit00/vim-prisma",
    ft = { "prisma" },
  },

  -- This plugin provides f/t/F/T mappings that can be customized by your setting.
  {
    "hrsh7th/vim-eft",
    lazy = true,
    config = function()
      vim.g.eft_ignorecase = true
    end,
  },

  "godlygeek/tabular",
  --}}}

  -- Tig in vim
  -- {{{
  {
    "iberianpig/tig-explorer.vim",
    lazy = true,
    cmd = { "Tig" },
  },
  -- }}}

  -- Vimspector
  -- {{{
  -- use {
  --   'puremourning/vimspector',
  --   -- opt = true,
  --   -- cmd = {'VimspectorContinue'},
  --   config = function ()
  --     local map = vim.api.nvim_set_keymap
  --     local opt = {noremap = false}
  --
  --     map('n', '<leader>dd', ':call vimspector#Launch()<CR>',opt)
  --     map('n', '<leader>de', ':call vimspector#Reset()<CR>',opt)
  --     map('n', '<leader>dr', ':call vimspector#Restart()<CR>',opt)
  --
  --     map('n', '<leader>dl', ':call vimspector#StepInto()<CR>',opt)
  --     map('n', '<leader>dh', ':call vimspector#StepOut()<CR>',opt)
  --     map('n', '<leader>dj', ':call vimspector#StopOver()<CR>',opt)
  --     map('n', '<leader>dc', ':call vimspector#Continue()<CR>',opt)
  --     map('n', '<leader>drc', '<Plug>VimspectorRunToCursor',opt)
  --     map('n', '<leader>dbp', '<Plug>VimspectorToggleBreakpoint',opt)
  --   end
  -- }
  -- }}}

  -- Vim async dispatch
  -- {{{
  {
    "tpope/vim-dispatch",
    lazy = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
  -- }}}

  -- UI
  -- {{{
  {
    "NTBBloodbath/galaxyline.nvim",
    -- branch = 'main',
    -- event = { 'VimEnter' },
    config = function()
      require("plugins.lightline")
    end,
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
  },

  -- Display color for hex string
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "html", "css", "sass", "vim", "typescript", "typescriptreact" },
    config = function()
      require("colorizer").setup({
        css = { rgb_fn = true },
        scss = { rgb_fn = true },
        sass = { rgb_fn = true },
        stylus = { rgb_fn = true },
        vim = { names = true },
        tmux = { names = false },
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        html = {
          mode = "foreground",
        },
      })
    end,
  },
  -- }}}

  -- SQL
  -- {{{
  "tpope/vim-dadbod",
  {
    "kristijanhusak/vim-dadbod-completion",
    config = function()
      vim.cmd([[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
        " Source is automatically added, you just need to include it in the chain complete list
        let g:completion_chain_complete_list = {
        \   'sql': [
        \    {'complete_items': ['vim-dadbod-completion']},
        \   ],
        \ }
        " Make sure `substring` is part of this list. Other items are optional for this completion source
        let g:completion_matching_strategy_list = ['exact', 'substring']
        " Useful if there's a lot of camel case items
        let g:completion_matching_ignore_case = 1
        ]])
    end,
  },
  "kristijanhusak/vim-dadbod-ui",
  -- }}}

  -- Developing Lua plugins
  --- {{{
  { "rafcamlet/nvim-luapad", dependencies = "antoinemadec/FixCursorHold.nvim" },
  {
    "folke/neodev.nvim",
    config = function()
      --config in lsp
    end,
  },
  --- }}}

  -- Notify
  -- popup is already imported
  --"nvim-lua/popup.nvim",
  "MunifTanjim/nui.nvim",

  -- Greeter
  -- {{{
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  "kyazdani42/nvim-web-devicons",

  {
    "khanghoang/dbx",
    dir = "~/dotfiles/xdg_config/.config/nvim_plugins/dbx",
  },

  -- Starlark
  -- {{{
  "cappyzawa/starlark.vim",
  -- }}}

  -- Copilot
  -- {{{
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          fugitive = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  },
  --- }}}
}
