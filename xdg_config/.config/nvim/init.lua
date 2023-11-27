-- vim: set foldmethod=marker foldlevel=0 foldlevelstart=0 foldenable :

-- Make the pane border thinner
vim.cmd([[highlight WinSeparator guibg=None]])

-- Use new regular expression engine
-- without this typescript highlighting will suffer due to 'redrawtime' exceeded, syntax highlighting disabled
-- https://jameschambers.co.uk/vim-typescript-slow
vim.cmd([[set re=0]])

--  :h scrolloff
vim.cmd([[set scrolloff=25]])

-- clipboard setting
-- vim.cmd [[set clipboard=unnamedplus]]
--
-- Hide command line
vim.cmd([[set cmdheight=0]])

-- Global status line
vim.cmd([[set laststatus=3]])

-- enable modeline
-- https://vim.fandom.com/wiki/Modeline_magic
vim.cmd([[set modeline]])

-- highlight line number
vim.cmd([[set cursorline]])
-- set the whole current line
vim.cmd([[highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]])
-- set color for number in the gutter
vim.cmd(
  [[highlight CursorLineNr cterm=NONE ctermbg=15 ctermfg=8 gui=NONE guibg=NONE guifg=#ffffff]]
)

vim.cmd([[set cmdheight=0]])
vim.cmd([[set laststatus=3]])
vim.cmd([[highlight WinSeparator guibg=None]])

-- Install lazy.vnim on fresh start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("general/settings")
require("lazy").setup("plugins")

-- order is important
require("colorschemes/lua/oceannext")
require("general/mappings")

-- for DBX's test command
require("libs.aerial_extend")
