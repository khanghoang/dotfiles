local api = vim.api
local MYVIMRC = '$HOME/.config/nvim/init.lua'

api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = false})

-- open vim config 
api.nvim_set_keymap('n', '<leader>ev', ':e $MYVIMRC<CR>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader>rv', ':source $MYVIMRC<CR>', {noremap = true, silent = true})

api.nvim_set_keymap('n', '<leader>cp', ":let @+=expand('%:p')<CR>", {noremap = true})
api.nvim_set_keymap('n', '<leader>gf', '<C-w>vgf', {noremap = true})
api.nvim_set_keymap('n', '<leader><leader>', '<C-^>', {noremap = true})

-- Esc key to clean seach result
api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', {noremap = true})