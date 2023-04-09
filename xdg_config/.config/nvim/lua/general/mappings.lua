local api = vim.api
local MYVIMRC = '$HOME/.config/nvim/init.lua'

api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'qq', ':q<cr>', { noremap = true, silent = true })

-- open vim config
api.nvim_set_keymap('n', '<leader>ev', ':lua require("plugins/find_dotfiles").find_dotfiles()<CR>',
  { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>rv', ':source $MYVIMRC<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader><space>', ':FZF<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>f', ':History<CR>', { noremap = true })

api.nvim_set_keymap('n', '<leader>cp', ":let @+=expand('%:p')<CR>", { noremap = true })
api.nvim_set_keymap('n', '<leader>gf', '<C-w>vgf', { noremap = true })
api.nvim_set_keymap('n', '<leader><leader>', '<C-^>', { noremap = true })

-- Esc key to clean seach result
api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { noremap = true })

api.nvim_set_keymap('n', 'Y', "y$", { noremap = true })

-- Keep it center
api.nvim_set_keymap('n', 'n', "nzzzv", { noremap = true })
api.nvim_set_keymap('n', 'N', "nzzzv", { noremap = true })

-- Reload bazel
api.nvim_set_keymap('n', '<leader>R', ":Dispatch! mbzl itest-reload-current<CR>", { noremap = true })
-- api.nvim_set_keymap('n', '<leader>R', ":lua require('plugins.utils').notify_output({ 'mbzl', 'itest-reload-current' })<CR>", { noremap = true })
-- api.nvim_set_keymap('n', '<leader>R', ":lua require('plugins.utils').notify_output({ 'echo', 'foo' })<CR>", { noremap = true })

-- Tabs
-- Go to tab number x -> xgt
-- Go to last accessed tab x -> g<Tab>
api.nvim_set_keymap('n', 'tc', ":tabclose<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tn', ":tabprevious<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tp', ":tabnext<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tN', ":tabnew<CR>", { noremap = true })

-- testing
vim.api.nvim_set_keymap('n', '<leader><leader>x', ":w<CR>:source %<CR>", { noremap = true })

-- easy save
vim.api.nvim_set_keymap('n', 'ss', ":w!<CR>", { noremap = true })

-- fix "gg" doens't work because statusbar=3 in neovim 0.8
vim.api.nvim_set_keymap('n', 'gg', ":0<CR>", { noremap = true })

-- F5 to insert current datetime
vim.api.nvim_set_keymap('n', '<F5>', "put=strftime('%c')<CR>P", { noremap = true })
vim.api.nvim_set_keymap('i', '<F5>', "<C-R>=strftime('%c')<CR>", { noremap = true })

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Using netrw instead of vifm
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
vim.api.nvim_set_keymap('n', '<leader>nt', ":Vifm<CR>", { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>nt', ":Vifm<CR>", { noremap = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').git_files, { desc = '[ ] Find find in current git dir' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]'})
-- Telescope live grep
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>lg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })

-- For marks management
vim.keymap.set('n', '<leader>a', ':Telescope vim_bookmarks all<CR>', { noremap = true })
vim.keymap.set('n', 'ql', ':cclose<CR>', { noremap = true })

-- Prettier current file
api.nvim_set_keymap('n', '<leader><leader>f', ":lua vim.lsp.buf.formatting { async = true }<CR>", { noremap = true })

-- Copy text
api.nvim_set_keymap('x', '<leader>c', "\"+y", { noremap = true })

-- using 'dts' as abbreviations
-- :help :map-expression
-- :help abbreviations
-- add "/" to the iskeyword since it's not a keyword
-- https://www.reddit.com/r/vim/comments/lfg95e/escape_characters_on_abbreviations/gmm9pqs/?utm_source=reddit&utm_medium=web2x&context=3
vim.cmd [[set iskeyword+=/]]

-- get current datetime by '/today'
vim.cmd [[iab <expr> /today strftime("%c")]]

-- copy current absolute path of current active buffer
vim.keymap.set('n', '<leader>ca', ':let @*=expand("%:p")<CR>', { desc = "[C]opy [A]bsolute path of current file"})
