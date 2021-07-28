local g = vim.g
local api = vim.api

g.ale_linters_explicit = 1
g.ale_lint_on_text_changed = 'never'
g.ale_lint_on_insert_leave = 0
g.ale_lint_on_enter = 1
g.ale_fix_on_save = 1

g.ale_set_loclist = 0
g.ale_set_quickfix = 1
g.ale_open_list = 0

g.ale_linters = {
  javascript = {'tsserver', 'eslint', 'prettier'},
  javascriptreact = {'tsserver', 'prettier'},
  typescriptreact = {'tsserver', 'prettier'},
}
g.ale_fixers = {
  javascript = {'prettier'},
  typescript = {'prettier'},
  javascriptreact = {'prettier'},
  typescriptreact = {'prettier'},
  json = {'prettier'},
}

api.nvim_set_keymap('n', '<leader>,f', '<Plug>(ale_fix)', {noremap = false, silent = false})
vim.g.ale_sign_error = '->'
vim.g.ale_sign_warning = '->'
