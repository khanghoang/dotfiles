return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'mhartington/oceanic-next'

  -- Navigation
  use 'vifm/vifm.vim'
  use 'rbgrouleff/bclose.vim'
  use 'easymotion/vim-easymotion'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'

  -- Completion
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'

  -- Statusline
  use 'itchyny/lightline.vim'
  use 'maximbaz/lightline-ale'
  use 'spywhere/lightline-lsp'

  -- Git support
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim'
  use 'airblade/vim-gitgutter'
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Language support
  use 'dense-analysis/ale'
  use 'tree-sitter/tree-sitter-typescript'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  -- use 'HerringtonDarkholme/yats.vim'
  -- use 'maxmellon/vim-jsx-pretty'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Misc
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'norcalli/nvim-colorizer.lua'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'tomtom/tcomment_vim'
  use 'frankier/neovim-colors-solarized-truecolor-only'

  -- Tig in vim
  use 'iberianpig/tig-explorer.vim'

  -- Vimspector
  use 'puremourning/vimspector'

  -- Navigate between LRU files
  -- use 'nvim-lua/popup.nvim'
  -- use 'nvim-lua/plenary.nvim'
  use 'ThePrimeagen/harpoon'

end)

