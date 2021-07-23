local g = vim.g
local api = vim.api

g.EasyMotion_do_mapping = 0
g.EasyMotion_smartcase = 1

vim.api.nvim_set_keymap('', '/', '<Plug>(easymotion-sn)', {noremap = false})
vim.api.nvim_set_keymap('o', '/', '<Plug>(easymotion-sn)', {noremap = false})
