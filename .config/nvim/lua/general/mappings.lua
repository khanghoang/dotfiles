local api = vim.api
local MYVIMRC = '$HOME/.config/nvim/init.lua'

api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- open vim config
api.nvim_set_keymap('n', '<leader>ev', ':lua require("plugins/find_dotfiles").find_dotfiles()<CR>',
  { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>rv', ':source $MYVIMRC<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader><space>', ':GitFiles<CR>', { noremap = true, silent = true })

api.nvim_set_keymap('n', '<leader>cp', ":let @+=expand('%:p')<CR>", { noremap = true })
api.nvim_set_keymap('n', '<leader>gf', '<C-w>vgf', { noremap = true })
api.nvim_set_keymap('n', '<leader><leader>', '<C-^>', { noremap = true })

-- Esc key to clean seach result
api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { noremap = true })

api.nvim_set_keymap('n', 'Y', "y$", { noremap = true })

-- Keep it center
api.nvim_set_keymap('n', 'n', "nzzzv", { noremap = true })
api.nvim_set_keymap('n', 'N', "nzzzv", { noremap = true })

-- Reload bazel
api.nvim_set_keymap('n', '<leader>R', ":Dispatch! bzl itest-reload-current<CR>", { noremap = true })

-- Tabs
api.nvim_set_keymap('n', 'tc', ":tabclose<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tn', ":tabprevious<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tp', ":tabnext<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tn', ":tabnew<CR>", { noremap = true })

-- testing
vim.api.nvim_set_keymap('n', '<leader><leader>x', ":w<CR>:source %<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><leader>r', ":lua require('plugins.lightline').reload()<CR>", { noremap = true })

-- easy save
vim.api.nvim_set_keymap('n', '<leader>s', ":w!<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>S', ":wq!<CR>", { noremap = true })

-- F5 to insert current datetime
vim.api.nvim_set_keymap('n', '<F5>', "put=strftime('%c')<CR>P", { noremap = true })
vim.api.nvim_set_keymap('i', '<F5>', "<C-R>=strftime('%c')<CR>", { noremap = true })

-- Telescope live grep
vim.api.nvim_set_keymap('n', '<leader>lg', ":Telescope live_grep<CR>", { noremap = true })

-- Prettier current file
api.nvim_set_keymap('n', '<leader><leader>f', ":lua vim.lsp.buf.formatting { async = true }<CR>", { noremap = true })

-- using 'dts' as abbreviations
-- :help :map-expression
-- :help abbreviations
-- add "/" to the iskeyword since it's not a keyword
-- https://www.reddit.com/r/vim/comments/lfg95e/escape_characters_on_abbreviations/gmm9pqs/?utm_source=reddit&utm_medium=web2x&context=3
vim.cmd [[set iskeyword+=/]]

-- get current datetime by '/today'
vim.cmd [[iab <expr> /today strftime("%c")]]
