return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    ft = {
      "typescriptreact",
      "typescript",
      "javascript",
      "javascriptreact",
      "lua",
      "bash",
      "go",
      "json",
      "python",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true,
        },
        ensure_installed = { "javascript", "lua", "bash", "go", "json", "typescript", "python" },
        highlight = {
          enable = true,
        },
        -- highlight_definitions = {
        --   enable = true,
        --   -- Set to false if you have an `updatetime` of ~100.
        --   clear_on_cursor_move = false,
        -- },
        -- refactor = {
        --   highlight_current_scope = { enable = true },
        -- },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["uc"] = "@comment.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]f"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })

      -- fix fold on typescriptreact
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.typescript.filetype_to_parsername = "typescriptreact"

      -- fold
      vim.cmd([[set foldmethod=expr]])
      vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
      -- this will fold EVERYTHINGGG!!!
      -- vim.cmd [[set foldlevel=1000]]
      -- disable auto fold when opening file
      vim.cmd([[set nofoldenable]])
    end,
  },
  {
    "tree-sitter/tree-sitter-typescript",
    ft = { "typescriptreact", "typescript", "javascript", "javascriptreact" },
  },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle" },
  },
}
