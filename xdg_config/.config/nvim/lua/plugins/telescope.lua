local action_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")
require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-/>"] = action_layout.toggle_preview
      },
      i = {
        ["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-/>"] = action_layout.toggle_preview
      },
    },
  },
})
