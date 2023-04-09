require('general/settings')

require('plugins')
require('plugins/vifm')
require('plugins/fzf')
require('plugins/autopairs')
require('plugins/gitgutter')
require('plugins/easymotion')
require('plugins/ale')
require('plugins/fugitive')
require('plugins/lsp')
require('plugins/gitlinker')
require('plugins/telescope')
require('plugins/find_dotfiles')
require('plugins/lightline')
require('plugins/query_sourcegraph')
require('plugins/dap')

require('colorschemes/lua/oceannext')
require('general/mappings')

-- Make the pane border thinner
vim.cmd [[highlight WinSeparator guibg=None]]

-- Use new regular expression engine
-- without this typescript highlighting will suffer due to 'redrawtime' exceeded, syntax highlighting disabled
-- https://jameschambers.co.uk/vim-typescript-slow
vim.cmd [[set re=0]]

--  :h scrolloff
vim.cmd [[set scrolloff=25]]

-- clipboard setting
-- vim.cmd [[set clipboard=unnamedplus]]
--
-- Hide command line
vim.cmd [[set cmdheight=0]]

-- Global status line
vim.cmd [[set laststatus=3]]

-- enable modeline
-- https://vim.fandom.com/wiki/Modeline_magic
vim.cmd [[set modeline]]

-- highlight line number
vim.cmd [[set cursorline]]
-- set the whole current line
vim.cmd [[highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]]
-- set color for number in the gutter
vim.cmd [[highlight CursorLineNr cterm=NONE ctermbg=15 ctermfg=8 gui=NONE guibg=NONE guifg=#ffffff]]

vim.cmd [[set cmdheight=0]]
vim.cmd [[set laststatus=3]]
vim.cmd [[highlight WinSeparator guibg=None]]


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
