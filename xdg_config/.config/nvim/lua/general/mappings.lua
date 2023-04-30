local api = vim.api
local MYVIMRC = "$HOME/.config/nvim/init.lua"

api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "qq", ":q<cr>", { noremap = true, silent = true })

-- open vim config
-- api.nvim_set_keymap('n', '<leader>ev', ':lua require("plugins/find_dotfiles").find_dotfiles()<CR>',
api.nvim_set_keymap("n", "<leader>ev", "<cmd>FZF $DOTFILES<CR>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<leader>rv", ":source $MYVIMRC<CR>", { noremap = true, silent = true })

-- https://github.com/junegunn/fzf/blob/master/README-VIM.md
vim.cmd([[
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
    copen
    cc
  endfunction

  " Override default ctrl action for h-split
  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',}

  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
  let g:fzf_layout = { 'down': "40%" }
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
  " https://github.com/junegunn/fzf.vim#preview-window
  let g:fzf_preview_window = ['hidden,right,50%', 'ctrl-/']

  command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, <bang>0)
]])
api.nvim_set_keymap(
  "n",
  "<leader><space>",
  ":GFiles<CR>",
  { noremap = true, silent = true, desc = "Git files" }
)
-- api.nvim_set_keymap('n', '<leader>f', ":Telescope oldfiles previewer=false theme=ivy winblend=10<CR>", { noremap = true })
api.nvim_set_keymap(
  "n",
  "<leader>f",
  ":History<CR>",
  { noremap = true, silent = true, desc = "File history" }
)

api.nvim_set_keymap("n", "<leader>gf", "<C-w>vgf", { noremap = true })
api.nvim_set_keymap("n", "<leader><leader>", "<C-^>", { noremap = true })

-- Esc key to clean seach result
api.nvim_set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true })

api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Keep it center
api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
api.nvim_set_keymap("n", "N", "nzzzv", { noremap = true })

-- Reload bazel
api.nvim_set_keymap(
  "n",
  "<leader>R",
  ":Dispatch! mbzl itest-reload-current<CR>",
  { noremap = true }
)

-- Tabs
-- Go to tab number x -> xgt
-- Go to last accessed tab x -> g<Tab>
api.nvim_set_keymap("n", "tc", ":tabclose<CR>", { noremap = true })
api.nvim_set_keymap("n", "tn", ":tabprevious<CR>", { noremap = true })
api.nvim_set_keymap("n", "tp", ":tabnext<CR>", { noremap = true })
api.nvim_set_keymap("n", "tN", ":tabnew<CR>", { noremap = true })

-- testing
vim.api.nvim_set_keymap(
  "n",
  "<leader>rl",
  ":w<CR>:source %<CR>:echo 'reload'<CR>",
  { noremap = true }
)

-- easy save
vim.api.nvim_set_keymap("n", "ss", ":w<CR>", { noremap = true })

-- fix "gg" doens't work because statusbar=3 in neovim 0.8
vim.api.nvim_set_keymap("n", "gg", ":0<CR>", { noremap = true })

-- reload module
vim.api.nvim_set_keymap(
  "n",
  ",rm",
  ":Telescope reloader theme=ivy previewer=false winblend=10<CR>",
  { noremap = true, desc = "[R]eload [M]odule" }
)

-- F5 to insert current datetime
vim.api.nvim_set_keymap("n", "<F5>", "put=strftime('%c')<CR>P", { noremap = true })
vim.api.nvim_set_keymap("i", "<F5>", "<C-R>=strftime('%c')<CR>", { noremap = true })

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Using netrw instead of vifm
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
vim.api.nvim_set_keymap("n", "<leader>nt", ":Vifm<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>nt", ":Vifm<CR>", { noremap = true })

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer]" })
-- Telescope live grep
vim.keymap.set(
  "n",
  "<leader>sf",
  require("telescope.builtin").find_files,
  { desc = "[S]earch [F]iles" }
)
vim.keymap.set(
  "n",
  "<leader>sh",
  require("telescope.builtin").help_tags,
  { desc = "[S]earch [H]elp" }
)
vim.keymap.set(
  "n",
  "<leader>sw",
  require("telescope.builtin").grep_string,
  { desc = "[S]earch current [W]ord" }
)
vim.keymap.set(
  "n",
  "<leader>lg",
  require("telescope.builtin").live_grep,
  { desc = "[S]earch by [G]rep" }
)
vim.keymap.set(
  "n",
  "<leader>sd",
  require("telescope.builtin").diagnostics,
  { desc = "[S]earch [D]iagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>sb",
  require("telescope.builtin").buffers,
  { desc = "[S]earch [B]uffers" }
)

-- For marks management
vim.keymap.set(
  "n",
  "ma",
  ":Telescope vim_bookmarks all theme=ivy winblend=10<CR>",
  { noremap = true }
)
vim.keymap.set("n", "<leader>ql", require("plugins.quickfix_list").toggle_qf, { noremap = true })

-- Copy text
api.nvim_set_keymap("x", "<leader>c", '"+y', { noremap = true })

-- set open key binding again due to click with tmux navigation
vim.api.nvim_set_keymap("n", "<C-\\>", ":ToggleTerm<cr>", { noremap = false, desc = "Toggle Term" })

-- using 'dts' as abbreviations
-- :help :map-expression
-- :help abbreviations
-- add "/" to the iskeyword since it's not a keyword
-- https://www.reddit.com/r/vim/comments/lfg95e/escape_characters_on_abbreviations/gmm9pqs/?utm_source=reddit&utm_medium=web2x&context=3
vim.cmd([[set iskeyword+=/]])

-- get current datetime by '/today'
vim.cmd([[iab <expr> /today strftime("%c")]])

-- copy current absolute path of current active buffer
vim.keymap.set(
  "n",
  "<leader>ca",
  ':let @*=expand("%:p")<CR>',
  { desc = "[C]opy [A]bsolute path of current file" }
)

-- open anything
vim.keymap.set("n", "gx", "<cmd>OpenAnything<CR>", { desc = "Open anything" })
