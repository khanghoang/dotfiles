local o = vim.o
local g = vim.g

o.hidden = true
o.modeline = false
o.swapfile = false
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.ruler = true
o.number = true
o.relativenumber = true
o.splitright = true
o.splitbelow = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.colorcolumn = '80'
-- o.listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<'
o.list = true
o.scrolloff = 10
o.regexpengine = 1
o.completeopt = 'menuone,noselect'
-- o.clipboard = o.clipboard .. 'unnamedplus'
o.lazyredraw = true
o.termguicolors = true
o.background = 'dark'

g.mapleader = ','

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source % | PackerCompile',
  group = packer_group,
  pattern = "plugins.lua"
})

-- save and restore folds
-- vim.cmd [[autocmd BufWinLeave *.* mkview]]
-- vim.cmd [[autocmd BufWinEnter *.* silent loadview]]

-- slow git-fugitive
vim.cmd [[set shell=bash]]
