" set termguicolors
call plug#begin()

Plug 'neovim/node-host'
Plug 'moll/vim-node'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'leafgarland/typescript-vim'
" Plug 'MaxMEllon/vim-jsx-pretty'

" UndoTree
Plug 'mbbill/undotree'

" Smooth scroll
Plug 'yuttie/comfortable-motion.vim'

" NERDTree + Ag
Plug 'taiansu/nerdtree-ag'

" Typescript
Plug 'leafgarland/typescript-vim'

" https://medium.com/@kuiro5/best-way-to-set-up-ctags-with-neovim-37be99c1bd11
" Ctags for NeoVim
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'heavenshell/vim-jsdoc'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'pangloss/vim-javascript', { 'for': '*javascript*' }
Plug 'mxw/vim-jsx', { 'for': '*javascript*' }
Plug 'leshill/vim-json'
Plug 'rking/ag.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'
Plug 'majutsushi/tagbar'
Plug 'szw/vim-tags'
Plug 'airblade/vim-gitgutter'
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
Plug 'neoclide/coc.nvim', { 'do': 'yarn install'  }

" Distract free writing
Plug 'junegunn/goyo.vim'

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

Plug 'romainl/flattened'
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '│'

Plug 'mhartington/oceanic-next'

Plug 'jiangmiao/auto-pairs'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'whatyouhide/vim-lengthmatters'

" ES2015 code snippets (Optional)
Plug 'Shougo/neosnippet.vim'
Plug 'epilande/vim-es2015-snippets'

" The donkey vim starting screen
Plug 'mhinz/vim-startify'

" React code snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
Plug 'SirVer/ultisnips'
Plug 'jhkersul/vim-jest-snippets'

Plug 'kana/vim-submode'

" Tig in vim
Plug 'rbgrouleff/bclose.vim'
Plug 'iberianpig/tig-explorer.vim'

" You will also need the following for function argument completion:
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

Plug 'tpope/vim-surround'

Plug 'frankier/neovim-colors-solarized-truecolor-only'

" auto reload
autocmd! bufwritepost init.vim so %

call plug#end()

" ------
" Configuration starts here
" ------

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
nnoremap <Leader><Space> :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'})) <CR>

"clear highlight search
nnoremap <Esc> :noh<CR><Esc>

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
" zc — close the fold (where your cursor is positioned)
" zM — close all folds on current buffer
" zo — open the fold (where your cursor is positioned)
" zR — open all folds on current buffer
" zj — cursor is moved to next fold
" zk — cursor is moved to previous fold
set foldmethod=syntax   
set foldnestmax=10
set foldcolumn=1
set nofoldenable
set foldlevel=99
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

nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>

" ctags open in vertical split
map <leader>,d :vsp <CR> <Plug>(coc-definition)
map <leader>,h <Plug>(coc-diagnostic-next)

let g:ale_sign_error = '→'
let g:ale_sign_warning = '→' 

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

" suppress ctags version warning (since universal-ctags)
let g:easytags_suppress_ctags_warning = 1

" {{ Gitgutter
" Gitgutter shortcuts
nmap <Leader>ha <Plug>GitGutterNextStageHunk
nmap <Leader>ho <Plug>GitGutterUndoHunk
nmap <Leader>,d <Plug>GitGutterNextHunk
nmap <Leader>,u <Plug>GitGutterPrevHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk

" Git gutter modified/added/removed signs
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_modified_removed = '│'
" }} Gitgutter

" {{ Vim Tig keymap
" open tig with current file
nnoremap <Leader>,T :TigOpenCurrentFile<CR>
" open tig with Project root path
nnoremap <Leader>,t :TigOpenProjectRootDir<CR>
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
" }} Vim Tig keymap

" {{ COC
" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Required for operations modifying multiple buffers like rename.
set hidden

" Remap keys for gotos
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>d <Plug>(coc-definition)
nmap <leader>y <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>r <Plug>(coc-references)

" Use <c-k> for trigger completion.
inoremap <silent><expr> <c-k> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" }} COC

" {{ ALE - Async lint engine
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

" go to next error	
vmap <Leader>,n :ALENext<CR>	
noremap <Leader>,n :ALENext<CR>	
vmap <Leader>,b :ALEPrevious<CR>	
noremap <Leader>,b :ALEPrevious<CR>	

vmap <Leader>,e :set g:ale_set_quickfix = 1<CR>
noremap <Leader>,e :set g:ale_set_quickfix = 1<CR>

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

" }} ALE

" {{ Move 1 line or a block of code up or down
nnoremap U   :<C-u>silent! move-2<CR>==
nnoremap D   :<C-u>silent! move+<CR>==
xnoremap U   :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap D   :<C-u>silent! '<,'>move'>+<CR>gv=gv
" }} Move 1 line or a block of code up or down

" " {{ coc-snippets
" Use <C-l> to trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> to select text for visual text of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> to jump to forward placeholder, which is default
let g:coc_snippet_next = '<c-j>'
" Use <C-k> to jump to backward placeholder, which is default
let g:coc_snippet_prev = '<c-k>'

let g:UltiSnipsExpandTrigger = '<F3>'
" }}
"
vmap <Leader>,b :Buffers<CR>
noremap <Leader>,b :Buffers<CR>
noremap <TAB><TAB> :ccl<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
noremap ; :GFiles?<CR>

nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

" Goyo command, call it by `:Writemode` and `:Codemode`
:command Writemode setlocal spell | Goyo 70
:command Codemode Goyo! 70

" highlight line number
set cursorline
" set the whole current line
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" set color for number in the gutter
highlight CursorLineNr cterm=NONE ctermbg=15 ctermfg=8 gui=NONE guibg=NONE guifg=#ffffff

" Vim tagbar config {{
" https://github.com/majutsushi/tagbar/wiki#typescript
let g:tagbar_type_typescript = {                                                  
      \ 'ctagsbin' : 'tstags',                                                        
      \ 'ctagsargs' : '-f-',                                                           
      \ 'kinds': [                                                                     
      \ 'e:enums:0:1',                                                               
      \ 'f:function:0:1',                                                            
      \ 't:typealias:0:1',                                                           
      \ 'M:Module:0:1',                                                              
      \ 'I:import:0:1',                                                              
      \ 'i:interface:0:1',                                                           
      \ 'C:class:0:1',                                                               
      \ 'm:method:0:1',                                                              
      \ 'p:property:0:1',                                                            
      \ 'v:variable:0:1',                                                            
      \ 'c:const:0:1',                                                              
      \ ],                                                                            
      \ 'sort' : 0                                                                    
      \ }   

nmap <c-p> :TagbarToggle<CR>
" }}

" Debug neovim nodejs plugins
" let g:coc_node_args = ['--nolazy', '--inspect-brk=9229']

" Vim smooth scroll config {{
let g:comfortable_motion_friction = 10.0
let g:comfortable_motion_air_drag = 10.0
" }}
