local api = vim.api
local MYVIMRC = '$HOME/.config/nvim/init.lua'

api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true, silent = true})

-- open vim config
api.nvim_set_keymap('n', '<leader>ev', ':lua require("plugins/find_dotfiles").find_dotfiles()<CR>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader>rv', ':source $MYVIMRC<CR>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader><space>', ':GitFiles<CR>', {noremap = true, silent = true})

api.nvim_set_keymap('n', '<leader>cp', ":let @+=expand('%:p')<CR>", {noremap = true})
api.nvim_set_keymap('n', '<leader>gf', '<C-w>vgf', {noremap = true})
api.nvim_set_keymap('n', '<leader><leader>', '<C-^>', {noremap = true})

-- Esc key to clean seach result
api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', {noremap = true})

api.nvim_set_keymap('n', 'Y', "y$", {noremap = true})

-- Keep it center
api.nvim_set_keymap('n', 'n', "nzzzv", {noremap = true})
api.nvim_set_keymap('n', 'N', "nzzzv", {noremap = true})

-- Reload bazel
api.nvim_set_keymap('n', '<leader>R', ":Dispatch! bzl itest-reload-current<CR>", {noremap = true})

-- Prettier current file
api.nvim_set_keymap('n', '<leader><leader>f', ":Dispatch! prettier % -w<CR>:edit!<CR>", {noremap = true})

-- Tabs
api.nvim_set_keymap('n', 'tc', ":tabclose<CR>", {noremap = true})
api.nvim_set_keymap('n', 'tn', ":tabprevious<CR>", {noremap = true})
api.nvim_set_keymap('n', 'tp', ":tabnext<CR>", {noremap = true})
api.nvim_set_keymap('n', 'tn', ":tabnew<CR>", {noremap = true})

-- testing 
vim.api.nvim_set_keymap('n', '<leader><leader>x', ":w<CR>:source %<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader><leader>r', ":lua require('neotest-vim-test.reload').reload()<CR>", {noremap = true})

-- easy save
vim.api.nvim_set_keymap('n', '<leader>s', ":w!<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>S', ":wq!<CR>", {noremap = true})
