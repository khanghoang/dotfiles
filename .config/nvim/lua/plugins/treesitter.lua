require('nvim-treesitter.configs').setup({
  ensure_installed = {'javascript', 'lua', 'bash', 'go', 'json', 'typescript', 'python'},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'gcn',
      node_decremental = 'gmn',
    },
  },
  refactor = {
    smart_rename = {
      enable = false,
      -- keymaps = {
      --   smart_rename = 'grr',
      -- },
    },
    navigation = {
      enable = false,
      -- keymaps = {
      --   goto_definition = 'gnd',
      --   list_definitions = 'gnD',
      --   list_definitions_toc = 'gO',
      -- },
    },
  },
})

-- fix fold on typescriptreact
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.typescript.used_by = "typescriptreact"

-- fold
vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
vim.cmd [[set foldlevel=1000]]
