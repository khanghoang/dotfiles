local g = vim.g
local api = vim.api

g.fzf_history_dir = "~/.local/share/fzf-history"

vim.cmd(
	[[command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case --hidden -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)]]
)

-- api.nvim_set_keymap('n', '<leader><space>', ':FZFMru<CR>', { noremap = true })
-- api.nvim_set_keymap('n', '<leader>f', ':History<CR>', { noremap = true })
-- api.nvim_set_keymap('n', '<leader>fg', ':Rg!<CR>', {noremap = true})
-- api.nvim_set_keymap('n', '<leader>fb', ':Buffers!<CR>', {noremap = true})
-- api.nvim_set_keymap('n', '<leader>fw', ':Rg!<C-R><C-W><CR>', {noremap = true})

vim.cmd([[
  command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
]])

vim.cmd([[
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()
]])

vim.cmd([[
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })
]])

-- api.nvim_set_keymap('n', '<leader>p', '<leader>ff', {noremap = false})
-- api.nvim_set_keymap('n', '<leader>s', '<leader>fg', {noremap = false})
-- api.nvim_set_keymap('n', '<leader>b', '<leader>fb', {noremap = false})
-- api.nvim_set_keymap('n', '<leader>w', '<leader>fw', {noremap = false})
