" set termguicolors
call plug#begin()

Plug 'neovim/node-host'
Plug 'moll/vim-node'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" UndoTree
Plug 'mbbill/undotree'

" NERDTree + Ag
Plug 'taiansu/nerdtree-ag'

" https://medium.com/@kuiro5/best-way-to-set-up-ctags-with-neovim-37be99c1bd11
" Ctags for NeoVim
Plug 'ludovicchabant/vim-gutentags'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript', { 'for': '*javascript*' }
Plug 'mxw/vim-jsx', { 'for': '*javascript*' }
Plug 'leshill/vim-json'
Plug 'rking/ag.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'
Plug 'majutsushi/tagbar'
Plug 'szw/vim-tags'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'skwp/vim-html-escape'
Plug 'justinmk/vim-sneak'
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'heavenshell/vim-jsdoc'
Plug 'sbdchd/neoformat'
Plug 'jparise/vim-graphql'

Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'

" vim-test config
" make test commands execute using neoterm
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'christoomey/vim-tmux-runner'
let test#strategy = "neoterm"

Plug 'Galooshi/vim-import-js'

Plug 'vim-scripts/git-time-lapse'

"Comment out stuffs
Plug 'tomtom/tcomment_vim'

Plug 'mhinz/vim-startify'
Plug 'romainl/flattened'
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '│'

Plug 'bootleq/vim-textobj-rubysymbol'
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-datetime'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'lucapette/vim-textobj-underscore'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'mhartington/oceanic-next'

Plug 'jiangmiao/auto-pairs'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'whatyouhide/vim-lengthmatters'

" ES2015 code snippets (Optional)
Plug 'Shougo/neosnippet.vim'
Plug 'epilande/vim-es2015-snippets'

" React code snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'kana/vim-submode'

" Tig in vim
Plug 'rbgrouleff/bclose.vim'
Plug 'iberianpig/tig-explorer.vim'

" ALE - Async lint engine {{{
let g:ale_fixers = {
\   'javascript': ['prettier_eslint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier-eslint', 'flow'],
\   'json': ['jsonlint'],
\   'zsh': ['shellcheck'],
\   'markdown': ['vale', 'writegood', 'alex']
\}

let g:ale_list_window_size = 5

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

let g:ale_open_list = 0
let g:ale_list_window_size = 5

nmap <Leader>h <Plug>(ale_previous_wrap)
nmap <Leader>l <Plug>(ale_next_wrap)

let g:deoplete#enable_at_startup = 1

Plug 'wokalski/autocomplete-flow'

" You will also need the following for function argument completion:
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

Plug 'tpope/vim-surround'

Plug 'frankier/neovim-colors-solarized-truecolor-only'

" auto reload
autocmd! bufwritepost init.vim so %

" LanguageClient plugin
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme OceanicNext
set background=dark
let g:airline_theme='oceanicnext'

let mapleader = ","

"Jump
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <Leader>nt :NERDTreeToggle<CR>
map <Leader>gf :ImportJSGoto<CR>
map <Leader>gc :Gstatus<CR>

nnoremap <Leader><Leader> <C-^>

imap jj <Esc>
imap jk <Esc>

"Remap VIM 0
noremap 0 ^
noremap ^ 0

" ignore case sensitive when searching
:set ignorecase

nnoremap gA :Ag! <cword><CR>
nnoremap <Leader><Space> :FZF <CR>

"clear highlight search
nnoremap <Esc> :noh<CR><Esc>

" Lightline ALE setting {{{
let g:lightline = {}

let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ }

let g:lightline.component_type = {
    \     'linter_checking': 'left',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'left',
    \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]], 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ] }
" }}}

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#disable_auto_complete = 0

let g:neoterm_size = '80v'
let g:neoterm_automap_keys = ',,t'
" Useful maps
" hide/close terminal
nnoremap <Leader>tg :call neoterm#toggle()<cr>

" allow to navigation as normal
au TermOpen *neoterm* :tnoremap <buffer> <Esc> <C-\><C-n>
au TermOpen *neoterm* :tnoremap <buffer> <C-h> <C-\><C-n><C-w>h
au TermOpen *neoterm* :tnoremap <buffer> <C-k> <C-\><C-n><C-w>k
au TermOpen *neoterm* :tnoremap <buffer> <C-j> <C-\><C-n><C-w>j
au TermOpen *neoterm* :tnoremap <buffer> <C-l> <C-\><C-n><C-w>l

"jsx highlight
let g:jsx_ext_required = 0

nnoremap <F3> :NumbersToggle<CR>

" Enable tmux navigation Ctrl+H
nmap <bs> :<c-u>TmuxNavigateLeft<cr>

let g:neosnippet#enable_snipmate_compatibility = 1

"Indention
set nocompatible
set smartindent
set autoindent
set nowrap
set noexpandtab
set softtabstop=2
set nosmarttab
set formatoptions+=n
set shiftwidth=2
" set encoding=utf-8
set virtualedit=all
set expandtab
set smartcase

" Code folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
let javaScript_fold=1 

" Font
" https://medium.com/@docodemore/an-alternative-to-operator-mono-font-5e5d040e1c7e#.z15iviagh
let g:Guifont="Operator Mono:h14"
set t_ZH=^[[3m
set t_ZR=^[[23m
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi jsModuleKeywords gui=italic
hi jsModuleOperators gui=italic
hi jsStorageClass gui=italic
hi jsOperator gui=italic
hi jsClassKeywords gui=italic

hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic
hi jsModuleKeywords cterm=italic
hi jsModuleOperators cterm=italic
hi jsStorageClass cterm=italic
hi jsOperator cterm=italic

"UI
set number

:imap jk <Esc>

noremap <Leader>ne :lNext<CR>
noremap <Leader>cl :lclose<CR>

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""" Language Client starts
" Required for operations modifying multiple buffers like rename.
set hidden

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }

" Let ALE do it job
let g:LanguageClient_diagnosticsEnable = 0

" <leader>d to go to definition
autocmd FileType javascript nnoremap <buffer>
  \ <leader>d :call LanguageClient_textDocument_definition()<cr>

" <leader>d to go to definition in another panel
autocmd FileType javascript nnoremap <buffer>
  \ <leader>,d :vsp <CR>:exec(":call LanguageClient_textDocument_definition()")<CR>

" <leader>t for "type" info under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>t :call LanguageClient_textDocument_hover()<cr>

" <leader>r to rename variable under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>r :call LanguageClient_textDocument_rename()<cr>

" <leader>s list symbols
autocmd FileType javascript nnoremap <buffer>
  \ <leader>s :call LanguageClient_textDocument_documentSymbol()<cr>

" <leader>f list all the references
autocmd FileType javascript nnoremap <buffer>
  \ <leader>f :call LanguageClient_textDocument_references()<cr>

""" Language Client ends


" Git time lapse
map <leader>gt :call TimeLapse() <cr> 

filetype plugin indent on

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Plug 'matze/vim-move'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" neo format for arettier
let g:neoformat_enabled_javascript = ['prettier']
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ none\ --tab-width\ 4\ --jsx-bracket-same-line\ true
let g:neoformat_try_formatprg = 1

" ==== NERD tree
" Open the project tree and expose current file in the nerdtree with Ctrl-\
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <Leader>\ :call OpenNerdTree()<CR>

" custom
vmap <Leader>,f :Neoformat<CR>
noremap <Leader>,f :Neoformat<CR>
vmap <Leader>,w :ImportJSFix<CR>
noremap <Leader>,w :ImportJSFix<CR>

vmap <Leader>,e :set g:ale_set_quickfix = 1<CR>
noremap <Leader>,e :set g:ale_set_quickfix = 1<CR>

nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>

" ctags open in vertical split
map <leader><C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp <CR>:exec("call LanguageClient_textDocument_definition()")<CR>

" go to next error	
vmap <Leader>,n :ALENext<CR>	
noremap <Leader>,n :ALENext<CR>	
vmap <Leader>,v :ALEPrevious<CR>	
noremap <Leader>,v :ALEPrevious<CR>	

" create file under current folder	
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>	
nnoremap <leader>,s :exe 'Ag!' expand('<cword>')<cr>

" enable mouse
set mouse=a

set nobackup
set nowritebackup
set noswapfile

" open neovim config in another window
" use ZZ to close it after changing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" multiple-cursors
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists('g:deoplete#disable_auto_complete') 
	   let g:deoplete#disable_auto_complete = 1
    endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    if exists('g:deoplete#disable_auto_complete')
	   let g:deoplete#disable_auto_complete = 0
    endif
endfunction

" Deoplete SuperTab like snippets behavior.
let g:UltiSnipsExpandTrigger = "<c-k>"

inoremap <expr><tab>
 \ pumvisible() ? "\<c-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
inoremap <expr><s-tab>
 \ pumvisible() ? "\<c-p>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<s-tab>"
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" open vertical on the right 
set splitright

" Fuzzy search NERDTreeBookmarks
function! s:open_bookmark_file(line)
  let parser = split(a:line)
  let path = parser[0]
  let linenumber = 0
  execute "edit +" . linenumber . " " . path
endfunction

command! -bang -nargs=* FuzzySearchBookmark
      \ call fzf#vim#ag(<q-args>,
      \   {
      \      'source': "cat ~/.NERDTreeBookmarks | awk '{print $2}' | sed 's#~#'\"$HOME\"'#g'",
      \      'options': '--no-hscroll --no-multi --ansi --prompt "Bookmark >>> " --preview "bat {}"',
      \      'down':    '50%',
      \      'sink': function('s:open_bookmark_file')
      \   },
      \   <bang>0
      \ )

nnoremap <Leader>,b :FuzzySearchBookmark <CR>

" Fuzzy search and checkout git branches
function! s:open_branch_fzf(line)
  let parser = split(a:line)
  let branch = parser[0];
  if branch ==? '*'
    let branch = parser[1]
  endif
  execute '!git checkout ' . branch
endfunction

command! -bang -nargs=* GCheckout
      \ call fzf#vim#ag(<q-args>,
      \   {
      \      'source': 'git branch',
      \      'options': '--no-hscroll --no-multi --ansi --prompt "Branch >>> " --preview "git log -200 --pretty=format:%s $(echo {+2..} |  sed \"s/$/../\" )"',
      \      'down':    '40%',
      \      'sink': function('s:open_branch_fzf')
      \   },
      \   <bang>0
      \ )

nnoremap <Leader>,c :GCheckout <CR>

" Gitgutter shortcuts
nmap <Leader>ha <Plug>GitGutterNextStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap hd <Plug>GitGutterNextHunk
nmap hu <Plug>GitGutterPrevHunk
nmap hp <Plug>GitGutterPreviewHunk

" suppress ctags version warning (since universal-ctags)
let g:easytags_suppress_ctags_warning = 1

" Git gutter modified/added/removed signs
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_modified_removed = '│'

" Vim Tig keymap
" open tig with current file
nnoremap <Leader>T :TigOpenCurrentFile<CR>
" open tig with Project root path
nnoremap <Leader>t :TigOpenProjectRootDir<CR>
" open tig grep
nnoremap <Leader>g :TigGrep<CR>
" resume from last grep
nnoremap <Leader>r :TigGrepResume<CR>
" open tig grep with the selected word
vnoremap <Leader>g y:TigGrep<Space><C-R>"<CR>
" open tig grep with the word under the cursor
nnoremap <Leader>cg :<C-u>:TigGrep<Space><C-R><C-W><CR>
" open tig blame with current file
nnoremap <Leader>b :Gblame<CR>
