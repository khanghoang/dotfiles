" set termguicolors
call plug#begin('~/.local/share/nvim/plugged')

Plug 'Lokaltog/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'haorenW1025/floatLf-nvim'
Plug 'vifm/vifm.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'rking/ag.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'sbdchd/neoformat'
Plug 'jparise/vim-graphql'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'vim-scripts/git-time-lapse'

" Measure the 
Plug 'tweekmonster/startuptime.vim'

"Comment out stuffs
Plug 'tomtom/tcomment_vim'

" Plug 'wellle/targets.vim'
" Plug 'majutsushi/tagbar'
" Plug 'szw/vim-tags'
" Plug 'skwp/vim-html-escape'
" Plug 'justinmk/vim-sneak'
" Plug 'MarcWeber/vim-addon-mw-utils'

Plug 'romainl/flattened'
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '│'

Plug 'mhartington/oceanic-next'

Plug 'jiangmiao/auto-pairs'
Plug 'whatyouhide/vim-lengthmatters'

" The donkey vim starting screen
Plug 'mhinz/vim-startify'

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
Plug 'puremourning/vimspector'

" auto reload
autocmd! bufwritepost init.vim so %

call plug#end()

" ------
" Configuration starts here
" ------

" disable swapfile
set noswapfile

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

map <Leader>nt :Vifm<CR>
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

" Font
" https://medium.com/@docodemore/an-alternative-to-operator-mono-font-5e5d040e1c7e#.z15iviagh
let g:Guifont="Operator Mono:h14"

"UI relative line number
set number relativenumber

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

nmap <silent> <Leader>t :TestNearest<CR>
nmap <silent> <Leader>T :TestFile<CR>

let g:ale_sign_error = '→'
let g:ale_sign_warning = '→' 

" create file under current folder	
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>	
nnoremap <leader>,s :exe 'Ag!' expand('<cword>')<cr>

" enable mouse
set mouse=a

set nobackup
set nowritebackup

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

let g:ale_reason_ls_executable = '/usr/bin/reason-language-server'
"" {{ ALE - Async lint engine
let g:ale_fixers = {
\   'javascript': ['prettier_eslint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier-eslint', 'flow'],
\   'json': ['jsonlint'],
\   'zsh': ['shellcheck'],
\   'markdown': ['vale', 'writegood', 'alex'],
\   'reason': [ 'reason-language-server' ]
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

vmap <Leader>,b :Buffers<CR>
noremap <Leader>,b :Buffers<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
" noremap ; :GFiles?<CR>

nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

" Goyo command, call it by `:Writemode` and `:Codemode`
command Writemode setlocal spell | Goyo 70
command Codemode Goyo! 70

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
" let g:coc_node_args = ['--nolazy', '--inspect=9229']

" Vim smooth scroll config {{
" let g:comfortable_motion_friction = 10.0
" let g:comfortable_motion_air_drag = 10.0
" }}

autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

if has('nvim') && exists('&winblend') && &termguicolors
  set winblend=0

  hi NormalFloat guibg=None
  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border'
  endif

  function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
          \ 'row': (&lines - height) / 2,
          \ 'col': (&columns - width) / 2,
          \ 'width': width,
          \ 'height': height }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  endfunction
endif
