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

require('colorschemes/lua/oceannext')
require('general/mappings')

vim.cmd [[
  let g:vimspector_base_dir='/home/khanghoang/.local/share/nvim/site/pack/packer/start/vimspector'
]]
