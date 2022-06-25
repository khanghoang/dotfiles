local api = vim.api
local MYVIMRC = '$HOME/.config/nvim/init.lua'

api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- open vim config
api.nvim_set_keymap('n', '<leader>ev', ':lua require("plugins/find_dotfiles").find_dotfiles()<CR>',
  { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader>rv', ':source $MYVIMRC<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<leader><space>', ':GitFiles<CR>', { noremap = true, silent = true })

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
api.nvim_set_keymap('n', '<leader>R', ":Dispatch! bzl itest-reload-current<CR>", { noremap = true })

-- Tabs
api.nvim_set_keymap('n', 'tc', ":tabclose<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tn', ":tabprevious<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tp', ":tabnext<CR>", { noremap = true })
api.nvim_set_keymap('n', 'tn', ":tabnew<CR>", { noremap = true })

-- testing
vim.api.nvim_set_keymap('n', '<leader><leader>x', ":w<CR>:source %<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><leader>r', ":lua require('plugins.lightline').reload()<CR>", { noremap = true })

-- easy save
vim.api.nvim_set_keymap('n', '<leader>s', ":w!<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>S', ":wq!<CR>", { noremap = true })

-- F5 to insert current datetime
vim.api.nvim_set_keymap('n', '<F5>', "put=strftime('%c')<CR>P", { noremap = true })
vim.api.nvim_set_keymap('i', '<F5>', "<C-R>=strftime('%c')<CR>", { noremap = true })

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
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

-- Prettier current file
api.nvim_set_keymap('n', '<leader><leader>f', ":lua vim.lsp.buf.formatting { async = true }<CR>", { noremap = true })

-- using 'dts' as abbreviations
-- :help :map-expression
-- :help abbreviations
-- add "/" to the iskeyword since it's not a keyword
-- https://www.reddit.com/r/vim/comments/lfg95e/escape_characters_on_abbreviations/gmm9pqs/?utm_source=reddit&utm_medium=web2x&context=3
vim.cmd [[set iskeyword+=/]]

-- get current datetime by '/today'
vim.cmd [[iab <expr> /today strftime("%c")]]
