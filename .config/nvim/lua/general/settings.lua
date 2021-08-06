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
o.clipboard = o.clipboard .. 'unnamedplus'
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

-- highlight line number
vim.cmd [[set cursorline]]
-- set the whole current line
vim.cmd [[highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]]
-- set color for number in the gutter
vim.cmd [[highlight CursorLineNr cterm=NONE ctermbg=15 ctermfg=8 gui=NONE guibg=NONE guifg=#ffffff]]

vim.cmd [[syntax on]] 
-- Use new regular expression engine
-- without this typescript highlighting will suffer due to 'redrawtime' exceeded, syntax highlighting disabled
-- https://jameschambers.co.uk/vim-typescript-slow
vim.cmd [[set re=0]]

--  :h scrolloff
vim.cmd [[set scrolloff=25]]

-- clipboard setting
vim.cmd [[set clipboard+=unnamedplus]]
