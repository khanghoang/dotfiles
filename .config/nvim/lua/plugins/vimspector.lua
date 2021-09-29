local api = vim.api

api.nvim_set_keymap('n', '<leader>dd', ':call vimspector#Launch()<CR>', {noremap = false})
api.nvim_set_keymap('n', '<leader>de', ':call vimspector#Reset()<CR>', {noremap = false})
api.nvim_set_keymap('n', '<leader>dr', ':call vimspector#Restart()<CR>', {noremap = false})

api.nvim_set_keymap('n', '<leader>dl', ':call vimspector#StepInto()<CR>', {noremap = false})
api.nvim_set_keymap('n', '<leader>dh', ':call vimspector#StepOut()<CR>', {noremap = false})
api.nvim_set_keymap('n', '<leader>dj', ':call vimspector#StopOver()<CR>', {noremap = false})
api.nvim_set_keymap('n', '<leader>dc', ':call vimspector#Continue()<CR>', {noremap = false})
api.nvim_set_keymap('n', '<leader>drc', '<Plug>VimspectorRunToCursor', {noremap = false})
api.nvim_set_keymap('n', '<leader>dbp', '<Plug>VimspectorToggleBreakpoint', {noremap = false})
