-- vim: set foldmethod=marker foldlevel=0 foldlevelstart=0 foldenable :

-- Install lazy.vnim on fresh start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("lazy").setup({
  -- Color schemes
  -- {{{
  "mhartington/oceanic-next",
  "frankier/neovim-colors-solarized-truecolor-only",
  -- }}}

  -- Navigation
  -- {{{
  "vifm/vifm.vim",
  "rbgrouleff/bclose.vim",
  "easymotion/vim-easymotion",
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  "junegunn/fzf.vim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local actions = require("fzf-lua.actions")
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        actions = {
          -- These override the default tables completely
          -- no need to set to `false` to disable an action
          -- delete or modify is sufficient
          files = {
            -- providers that inherit these actions:
            --   files, git_files, git_status, grep, lsp
            --   oldfiles, quickfix, loclist, tags, btags
            --   args
            -- default action opens a single selection
            -- or sends multiple selection to quickfix
            -- replace the default action with the below
            -- to open all files whether single or multiple
            -- ["default"]     = actions.file_edit,
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-l"] = actions.file_sel_to_ll,
          },
          buffers = {
            -- providers that inherit these actions:
            --   buffers, tabs, lines, blines
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          },
        },
        fzf_opts = {
          -- options are sent as `<left>=<right>`
          -- set to `false` to remove a flag
          -- set to '' for a non-value flag
          -- for raw args use `fzf_args` instead
          ["--ansi"] = "",
          ["--layout"] = "reverse-list",
          ["--border"] = "top",
        },
        grep = {
          actions = {
            -- actions inherit from 'actions.files' and merge
            -- this action toggles between 'grep' and 'live_grep'
            ["ctrl-f"] = { actions.grep_lgrep },
          },
        },
      })
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
      })

      vim.api.nvim_set_keymap(
        "n",
        "<C-h>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-j>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-k>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-l>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-\\>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<C-Space>",
        ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>",
        { noremap = true, silent = true }
      )
    end,
  },
  -- }}}

  -- LSP
  --- {{{
  {
    "nvim-lua/lsp-status.nvim",
    config = function()
      local lsp_status = require("lsp-status")
      local LSP_KIND_SIGNS = {
        Text = "  ",
        Method = "  ",
        Function = "  ",
        Constructor = "  ",
        Field = "  ",
        Variable = "  ",
        Class = "  ",
        Interface = "  ",
        Module = "  ",
        Property = "  ",
        Unit = "  ",
        Value = "  ",
        Enum = "  ",
        Keyword = "  ",
        Snippet = "  ",
        Color = "  ",
        File = "  ",
        Reference = "  ",
        Folder = "  ",
        EnumMember = "  ",
        Constant = "  ",
        Struct = "  ",
        Event = "  ",
        Operator = "  ",
        TypeParameter = "  ",
        Copilot = "",
      }

      lsp_status.config({
        kind_labels = LSP_KIND_SIGNS,
        status_symbol = "",
        diagnostics = false,
      })
      lsp_status.register_progress()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
    dependencies = { "williamboman/nvim-lsp-installer" },
  },

  {
    "glepnir/lspsaga.nvim",
    -- branch = 'nvim6.0'
    lazy = true,
    branch = "main",
    event = "LspAttach",
    config = function()
      require("plugins.lsp_saga")
    end,
    dependencies = {
      { "kyazdani42/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },

  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.aerial")
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() end,
  },

  {
    "sourcegraph/sg.nvim",
    build = "cargo build --workspace",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    },
  },

  --}}}

  -- Completion
  -- {{{
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.nvim_cmp")
    end,
    dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "neovim/nvim-lspconfig" },
  },

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "/home/khanghoang/.config/nvim/lua/snippets/vscode-jest-snippets" },
      })
      local ls = require("luasnip")

      -- <c-k> is my expansion key
      -- this will expand the current item or jump to the next item within the snippet.
      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      -- <c-j> is my jump backwards key.
      -- this always moves to the previous item within the snippet
      vim.keymap.set({ "i", "s" }, "<c-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- <c-l> is selecting within a list of options.
      -- This is useful for choice nodes (introduced in the forthcoming episode 2)
      vim.keymap.set("i", "<c-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },

  -- }}}

  -- Git support
  -- {{{
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.gitsigns")
    end,
  },

  -- }}}

  -- Language support
  -- {{{
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    config = function() end,
  },
  -- }}}

  -- TreeSitter
  -- {{{
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
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
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

  -- run and display test results
  -- use {
  --   "rcarriga/neotest",
  --   -- "~/code/neotest",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     -- disable due to a weird error about duplicated function declaration
  --     "antoinemadec/FixCursorHold.nvim",
  --     "vim-test/vim-test",
  --     "rcarriga/neotest-vim-test",
  --     -- local dev
  --     -- '~/code/neotest-vim-test',
  --     "rcarriga/neotest-plenary",
  --   },
  --   config = function()
  --     local g = vim.g
  --     -- in millisecond, used for both CursorHold and CursorHoldI,
  --     -- use updatetime instead if not defined
  --     g.cursorhold_updatetime = 100
  --
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }),
  --         -- why do we need this???
  --         -- require("neotest-plenary")
  --       }
  --     })
  --
  --     -- disable for testing
  --     -- g["test#javascript#runner"] = 'jest'
  --     -- g["test#typescript#runner"] = 'jest'
  --     -- g["test#strategy"] = 'dispatch_background'
  --
  --     -- usage:
  --     -- 1. Run test (for example :TestNearest)
  --     -- 2. <C-o> to scroll through the test results
  --     -- 3. <C-o> on the failed test LOC to open it in vim
  --     vim.cmd [[tmap <C-o> <C-\><C-n>]]
  --
  --     vim.api.nvim_set_keymap('n', '<leader>tn', ":TestNearest<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tf', ":TestNearest<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>ts', ":TestNearest<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tl', ":TestLast<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tl', ":TestLast<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tr', ":lua require('neotest').run.run()<CR>", { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>tt', ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  --       { noremap = true })
  --     vim.api.nvim_set_keymap('n', '<leader>to', ":lua require('neotest').summary.open()<CR>", { noremap = true })
  --   end
  -- }

  -- }}}

  -- Filetypes
  -- {{{
  -- Generate table of content from a markdown file
  -- Mostly for Table of Content, zk is for another purpose
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
  },
  {
    "ellisonleao/glow.nvim",
    branch = "main",
    ft = { "markdown" },
  },
  -- }}}

  -- Misc
  --- {{{
  -- Written in Lua
  -- This plug-in provides automatic closing of quotes, parenthesis, brackets
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  -- Same as the above
  -- use {
  --   'Raimondi/delimitMate',
  --   event = 'InsertEnter',
  --   config = function()
  --     vim.g.delimitMate_expand_cr = 0
  --     vim.g.delimitMate_expand_space = 1
  --     vim.g.delimitMate_smart_quotes = 1
  --     vim.g.delimitMate_expand_inside_quotes = 0
  --     vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
  --   end
  -- }

  -- Usage:
  -- c      s               "      '
  -- ^      ^               ^      ^
  -- change surround` from `"` to `'`
  -- d      s          "
  -- ^      ^          ^
  -- delete surround` `"`
  --- Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by `S"`
  "tpope/vim-surround",

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  "christoomey/vim-tmux-navigator",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- find the matching characters for {}, [], etc
  -- https://github.com/andymass/vim-matchup#a2-jump-to-open-and-close-words
  { "andymass/vim-matchup", event = "VimEnter" },
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.telescope")
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
  },

  -- support prisma schema
  {
    "pantharshit00/vim-prisma",
    ft = { "prisma" },
  },

  -- This plugin provides f/t/F/T mappings that can be customized by your setting.
  {
    "hrsh7th/vim-eft",
    lazy = true,
    config = function()
      vim.g.eft_ignorecase = true
    end,
  },

  "godlygeek/tabular",

  --}}}

  -- Tig in vim
  -- {{{
  {
    "iberianpig/tig-explorer.vim",
    lazy = true,
    cmd = { "Tig" },
  },
  -- }}}

  -- Vimspector
  -- {{{
  -- use {
  --   'puremourning/vimspector',
  --   -- opt = true,
  --   -- cmd = {'VimspectorContinue'},
  --   config = function ()
  --     local map = vim.api.nvim_set_keymap
  --     local opt = {noremap = false}
  --
  --     map('n', '<leader>dd', ':call vimspector#Launch()<CR>',opt)
  --     map('n', '<leader>de', ':call vimspector#Reset()<CR>',opt)
  --     map('n', '<leader>dr', ':call vimspector#Restart()<CR>',opt)
  --
  --     map('n', '<leader>dl', ':call vimspector#StepInto()<CR>',opt)
  --     map('n', '<leader>dh', ':call vimspector#StepOut()<CR>',opt)
  --     map('n', '<leader>dj', ':call vimspector#StopOver()<CR>',opt)
  --     map('n', '<leader>dc', ':call vimspector#Continue()<CR>',opt)
  --     map('n', '<leader>drc', '<Plug>VimspectorRunToCursor',opt)
  --     map('n', '<leader>dbp', '<Plug>VimspectorToggleBreakpoint',opt)
  --   end
  -- }
  -- }}}

  -- Debugger
  -- {{{
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      --   require'mason-tool-installer'.setup {
      --     -- a list of all tools you want to ensure are installed upon
      --     -- start; they should be the names Mason uses for each tool
      --     ensure_installed = {
      --
      --       -- you can pin a tool to a particular version
      --       -- { 'golangci-lint', version = '1.47.0' },
      --
      --       -- you can turn off/on auto_update per tool
      --       { 'bash-language-server', auto_update = false },
      --       'cmake-language-server',
      --       'debugpy',
      --       'dockerfile-language-server',
      --       'grammarly-languageserver',
      --       'json-lsp',
      --       'lua-language-server',
      --       'node-debug2-adapter',
      --       'pyright',
      --       'tailwindcss-language-server',
      --       'typescript-language-server',
      --       'zk',
      --       'prettier',
      --       'sql-formatter',
      --     },
      --
      --     -- if set to true this will check each tool for updates. If updates
      --     -- are available the tool will be updated.
      --     -- Default: false
      --     auto_update = false,
      --
      --     -- automatically install / update on startup. If set to false nothing
      --     -- will happen on startup. You can use `:MasonToolsUpdate` to install
      --     -- tools and check for updates.
      --     -- Default: true
      --     run_on_start = true,
      --
      --     -- set a delay (in ms) before the installation starts. This is only
      --     -- effective if run_on_start is set to true.
      --     -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
      --     -- Default: 0
      --     start_delay = 3000  -- 3 second delay
      --   }
    end,
    -- requires = { "WhoIsSethDaniel/mason-tool-installer" }
  },

  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("plugins.dap")
    end,
  },
  -- persists breakpoints
  -- config is loaded in plugins.dap
  "Weissle/persistent-breakpoints.nvim",
  -- }}}

  -- Vim async dispatch
  -- {{{
  {
    "tpope/vim-dispatch",
    lazy = true,
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
  -- }}}

  -- UI
  -- {{{
  {
    "NTBBloodbath/galaxyline.nvim",
    -- branch = 'main',
    -- event = { 'VimEnter' },
    config = function()
      require("plugins.lightline")
    end,
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        whitespace = {
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
      })
      -- vim.g.indent_blankline_char = "│"
      -- vim.g.indent_blankline_show_first_indent_level = true
      -- vim.g.show_trailing_blankline_indent = false
      -- vim.g.indent_blankline_filetype_exclude = {
      --   "startify",
      --   "dashboard",
      --   "dotooagenda",
      --   "log",
      --   "fugitive",
      --   "gitcommit",
      --   "packer",
      --   "vimwiki",
      --   "markdown",
      --   "json",
      --   "txt",
      --   "vista",
      --   "help",
      --   "todoist",
      --   "NvimTree",
      --   "peekaboo",
      --   "git",
      --   "TelescopePrompt",
      --   "undotree",
      --   "flutterToolsOutline",
      --   "dbui",
      --   "dbout",
      --   "sql",
      --   "", -- for all buffers without a file type
      -- }
      -- vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
      -- vim.g.indent_blankline_show_trailing_blankline_indent = false
      -- vim.g.indent_blankline_show_current_context = true
      -- vim.g.indent_blankline_context_patterns = {
      --   "abstract_class_declaration",
      --   "abstract_method_signature",
      --   "accessibility_modifier",
      --   "ambient_declaration",
      --   "arguments",
      --   "array",
      --   "array_pattern",
      --   "array_type",
      --   "arrow_function",
      --   "as_expression",
      --   "asserts",
      --   "assignment_expression",
      --   "assignment_pattern",
      --   "augmented_assignment_expression",
      --   "await_expression",
      --   "binary_expression",
      --   "break_statement",
      --   "call_expression",
      --   "call_signature",
      --   "catch_clause",
      --   "class",
      --   "class_body",
      --   "class_declaration",
      --   "class_heritage",
      --   "computed_property_name",
      --   "conditional_type",
      --   "constraint",
      --   "construct_signature",
      --   "constructor_type",
      --   "continue_statement",
      --   "debugger_statement",
      --   "declaration",
      --   "decorator",
      --   "default_type",
      --   "do_statement",
      --   "else_clause",
      --   "empty_statement",
      --   "enum_assignment",
      --   "enum_body",
      --   "enum_declaration",
      --   "existential_type",
      --   "export_clause",
      --   "export_specifier",
      --   "export_statement",
      --   "expression",
      --   "expression_statement",
      --   "extends_clause",
      --   "finally_clause",
      --   "flow_maybe_type",
      --   "for_in_statement",
      --   "for_statement",
      --   "formal_parameters",
      --   "function",
      --   "function_declaration",
      --   "function_signature",
      --   "function_type",
      --   "generator_function",
      --   "generator_function_declaration",
      --   "generic_type",
      --   "if_statement",
      --   "implements_clause",
      --   "import",
      --   "import_alias",
      --   "import_clause",
      --   "import_require_clause",
      --   "import_specifier",
      --   "import_statement",
      --   "index_signature",
      --   "index_type_query",
      --   "infer_type",
      --   "interface_declaration",
      --   "internal_module",
      --   "intersection_type",
      --   "jsx_attribute",
      --   "jsx_closing_element",
      --   "jsx_element",
      --   "jsx_expression",
      --   "jsx_fragment",
      --   "jsx_namespace_name",
      --   "jsx_opening_element",
      --   "jsx_self_closing_element",
      --   "labeled_statement",
      --   "lexical_declaration",
      --   "literal_type",
      --   "lookup_type",
      --   "mapped_type_clause",
      --   "member_expression",
      --   "meta_property",
      --   "method_definition",
      --   "method_signature",
      --   "module",
      --   "named_imports",
      --   "namespace_import",
      --   "nested_identifier",
      --   "nested_type_identifier",
      --   "new_expression",
      --   "non_null_expression",
      --   "object",
      --   "object_assignment_pattern",
      --   "object_pattern",
      --   "object_type",
      --   "omitting_type_annotation",
      --   "opting_type_annotation",
      --   "optional_parameter",
      --   "optional_type",
      --   "pair",
      --   "pair_pattern",
      --   "parenthesized_expression",
      --   "parenthesized_type",
      --   "pattern",
      --   "predefined_type",
      --   "primary_expression",
      --   "program",
      --   "property_signature",
      --   "public_field_definition",
      --   "readonly_type",
      --   "regex",
      --   "required_parameter",
      --   "rest_pattern",
      --   "rest_type",
      --   "return_statement",
      --   "sequence_expression",
      --   "spread_element",
      --   "statement",
      --   "statement_block",
      --   "string",
      --   "subscript_expression",
      --   "switch_body",
      --   "switch_case",
      --   "switch_default",
      --   "switch_statement",
      --   "template_string",
      --   "template_substitution",
      --   "ternary_expression",
      --   "throw_statement",
      --   "try_statement",
      --   "tuple_type",
      --   "type_alias_declaration",
      --   "type_annotation",
      --   "type_arguments",
      --   "type_parameter",
      --   "type_parameters",
      --   "type_predicate",
      --   "type_predicate_annotation",
      --   "type_query",
      --   "unary_expression",
      --   "union_type",
      --   "update_expression",
      --   "variable_declaration",
      --   "variable_declarator",
      --   "while_statement",
      --   "with_statement",
      --   "yield_expression",
      -- }
      -- because lazy load indent-blankline so need readd this autocmd
      -- vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
    end,
  },

  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npm run compile",
  },
  { "jbyuki/one-small-step-for-vimkind" },

  -- replaced by vim illuminate
  -- use {
  --   'itchyny/vim-cursorword',
  --   event = {'BufReadPre','BufNewFile'},
  --   config = function()
  --     vim.api.nvim_command('augroup user_plugin_cursorword')
  --     vim.api.nvim_command('autocmd!')
  --     vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0')
  --     vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
  --     vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
  --     vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
  --     vim.api.nvim_command('augroup END')
  --   end,
  -- }

  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.illuminate")
    end,
  },

  -- -- Display the winbar/breadcrumb
  -- use({
  --   "SmiteshP/nvim-gps",
  --   requires = "nvim-treesitter/nvim-treesitter",
  --   config = function ()
  --     require("nvim-gps").setup()
  --     -- Lua
  --     -- Winbar
  --     --- {{{
  --     vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
  --       callback = function()
  --         require("plugins.winbar").get_winbar()
  --       end,
  --     })
  -- -- }}}
  --   end
  -- })

  -- Display color for hex string
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "html", "css", "sass", "vim", "typescript", "typescriptreact" },
    config = function()
      require("colorizer").setup({
        css = { rgb_fn = true },
        scss = { rgb_fn = true },
        sass = { rgb_fn = true },
        stylus = { rgb_fn = true },
        vim = { names = true },
        tmux = { names = false },
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        html = {
          mode = "foreground",
        },
      })
    end,
  },

  -- use {
  --   'kdheepak/tabline.nvim',
  --   config = function()
  --     require'tabline'.setup {
  --       -- Defaults configuration options
  --       enable = true,
  --       options = {
  --         -- If lualine is installed tabline will use separators configured in lualine by default.
  --         -- These options can be used to override those settings.
  --         section_separators = {'|', '|'},
  --         component_separators = {'|', '|'},
  --         max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
  --         show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
  --         show_devicons = false, -- this shows devicons in buffer section
  --         show_bufnr = false, -- this appends [bufnr] to buffer section,
  --         show_filename_only = true, -- shows base filename only instead of relative path in filename
  --       }
  --     }
  --
  --     vim.cmd[[
  --       set guioptions-=e " Use showtabline in gui vim
  --       set sessionoptions+=tabpages,globals " store tabpages and globals in session
  --     ]]
  --
  --     -- require'lualine'.setup {
  --     --   tabline = {
  --     --     lualine_a = {},
  --     --     lualine_b = {},
  --     --     lualine_c = { require'tabline'.tabline_buffers },
  --     --     lualine_x = { require'tabline'.tabline_tabs },
  --     --     lualine_y = {},
  --     --     lualine_z = {},
  --     --   },
  --     -- }
  --
  --   end,
  --   -- requires = { { 'nvim-lualine/lualine.nvim'}, {'kyazdani42/nvim-web-devicons', opt = true} }
  --   requires = { {'kyazdani42/nvim-web-devicons', opt = true} }
  -- }

  -- }}}

  -- Note taking
  -- {{{
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "select",
        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },
          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })

      -- https://github.com/mickael-menu/zk-nvim#example-mappings
      local opts = { noremap = true, silent = false }

      -- Create a new note after asking for its title.
      -- Conflicted with the ft one
      vim.api.nvim_set_keymap(
        "n",
        "<leader>zn",
        "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
        opts
      )

      -- integrate with telescope
      require("telescope").load_extension("zk")

      -- Open notes.
      vim.api.nvim_set_keymap("n", "<leader>zo", ":Telescope zk notes<CR>", opts)
      -- Open notes associated with the selected tags.
      vim.api.nvim_set_keymap("n", "<leader>zt", ":Telescope zk tags<CR>", opts)

      -- Search for the notes matching a given query.
      vim.api.nvim_set_keymap(
        "n",
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>",
        opts
      )
      -- Search for the notes matching the current visual selection.
      vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>zn",
        "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: '), datetime = 'today' }<CR>",
        opts
      )
    end,
  },
  -- }}}

  -- SQL
  -- {{{
  "tpope/vim-dadbod",
  {
    "kristijanhusak/vim-dadbod-completion",
    config = function()
      vim.cmd([[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
        " Source is automatically added, you just need to include it in the chain complete list
        let g:completion_chain_complete_list = {
        \   'sql': [
        \    {'complete_items': ['vim-dadbod-completion']},
        \   ],
        \ }
        " Make sure `substring` is part of this list. Other items are optional for this completion source
        let g:completion_matching_strategy_list = ['exact', 'substring']
        " Useful if there's a lot of camel case items
        let g:completion_matching_ignore_case = 1
        ]])
    end,
  },
  "kristijanhusak/vim-dadbod-ui",
  -- }}}

  -- Uncategorized
  -- Waiting to be removed
  -- {{{
  -- use {
  --   'kana/vim-operator-replace',
  --   keys = {{'x','p'}},
  --   config = function()
  --     vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
  --   end,
  --   requires = 'kana/vim-operator-user'
  -- }
  --
  -- use {
  --   'rhysd/vim-operator-surround',
  --   event = 'BufRead',
  --   requires = 'kana/vim-operator-user'
  -- }
  --
  -- use {
  --   'kana/vim-niceblock',
  --   opt = true
  -- }
  -- }}}

  -- Developing Lua plugins
  --- {{{
  { "rafcamlet/nvim-luapad", dependencies = "antoinemadec/FixCursorHold.nvim" },
  {
    "folke/neodev.nvim",
    config = function()
      --config in lsp
    end,
  },
  --- }}}
  --- }}}

  -- Notify
  -- popup is already imported
  --"nvim-lua/popup.nvim",
  "MunifTanjim/nui.nvim",

  -- Notify
  -- {{{
  -- use {
  --   'rcarriga/nvim-notify',
  --   config = function ()
  --     -- LSP integration
  --     -- Make sure to also have the snippet with the common helper functions in your config!
  --     -- Utility functions shared between progress reports for LSP and DAP
  --     vim.notify = require('notify')
  --     local client_notifs = {}
  --
  --     local function get_notif_data(client_id, token)
  --      if not client_notifs[client_id] then
  --        client_notifs[client_id] = {}
  --      end
  --
  --      if not client_notifs[client_id][token] then
  --        client_notifs[client_id][token] = {}
  --      end
  --
  --      return client_notifs[client_id][token]
  --     end
  --
  --
  --     local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
  --
  --     local function update_spinner(client_id, token)
  --      local notif_data = get_notif_data(client_id, token)
  --
  --      if notif_data.spinner then
  --        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
  --        notif_data.spinner = new_spinner
  --
  --        notif_data.notification = vim.notify(nil, nil, {
  --          hide_from_history = true,
  --          icon = spinner_frames[new_spinner],
  --          replace = notif_data.notification,
  --        })
  --
  --        vim.defer_fn(function()
  --          update_spinner(client_id, token)
  --        end, 100)
  --      end
  --     end
  --
  --     local function format_title(title, client_name)
  --      return client_name .. (#title > 0 and ": " .. title or "")
  --     end
  --
  --     local function format_message(message, percentage)
  --      return (percentage and percentage .. "%\t" or "") .. (message or "")
  --     end
  --
  --     vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  --      local client_id = ctx.client_id
  --
  --      local val = result.value
  --
  --      if not val.kind then
  --        return
  --      end
  --
  --      local notif_data = get_notif_data(client_id, result.token)
  --
  --      if val.kind == "begin" then
  --        local message = format_message(val.message, val.percentage)
  --
  --        notif_data.notification = vim.notify(message, "info", {
  --          title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
  --          icon = spinner_frames[1],
  --          timeout = false,
  --          hide_from_history = false,
  --        })
  --
  --        notif_data.spinner = 1
  --        update_spinner(client_id, result.token)
  --      elseif val.kind == "report" and notif_data then
  --        notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
  --          replace = notif_data.notification,
  --          hide_from_history = false,
  --        })
  --      elseif val.kind == "end" and notif_data then
  --        notif_data.notification =
  --          vim.notify(val.message and format_message(val.message) or "Complete", "info", {
  --            icon = "",
  --            replace = notif_data.notification,
  --            timeout = 3000,
  --          })
  --
  --        notif_data.spinner = nil
  --      end
  --     end
  --
  --     -- DAP integration
  --     -- Make sure to also have the snippet with the common helper functions in your config!
  --     local dap = require"dap"
  --
  --     dap.listeners.before['event_progressStart']['progress-notifications'] = function(session, body)
  --      local notif_data = get_notif_data("dap", body.progressId)
  --
  --      local message = format_message(body.message, body.percentage)
  --      notif_data.notification = vim.notify(message, "info", {
  --        title = format_title(body.title, session.config.type),
  --        icon = spinner_frames[1],
  --        timeout = false,
  --        hide_from_history = false,
  --      })
  --
  --      notif_data.notification.spinner = 1,
  --      update_spinner("dap", body.progressId)
  --     end
  --
  --     dap.listeners.before['event_progressUpdate']['progress-notifications'] = function(session, body)
  --      local notif_data = get_notif_data("dap", body.progressId)
  --      notif_data.notification = vim.notify(format_message(body.message, body.percentage), "info", {
  --        replace = notif_data.notification,
  --        hide_from_history = false,
  --      })
  --     end
  --
  --     dap.listeners.before['event_progressEnd']['progress-notifications'] = function(session, body)
  --      local notif_data = client_notifs["dap"][body.progressId]
  --      notif_data.notification = vim.notify(body.message and format_message(body.message) or "Complete", "info", {
  --         icon = "",
  --         replace = notif_data.notification,
  --         timeout = 3000
  --      })
  --      notif_data.spinner = nil
  --     end
  --   end
  -- }
  -- }}}

  -- Greeter
  -- {{{
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  "kyazdani42/nvim-web-devicons",

  {
    "khanghoang/dbx",
    dir = "~/dotfiles/xdg_config/.config/nvim_plugins/dbx",
  },
  -- }}}
  -- Test runner
  -- {{{
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-plenary",
      "vim-test/vim-test", -- for lua's busted
    },
    config = function()
      require("plugins.neotest")
    end,
  },
  -- }}}

  -- Test runners
  -- disabled due to https://github.com/klen/nvim-test/issues/36
  -- {{{
  --  use {
  --    "klen/nvim-test",
  --    config = function()
  --
  --      local Runner = require "nvim-test.runner"
  --
  --      local query = [[
  --        ((expression_statement
  --          (call_expression
  --            function: (identifier) @method-name
  --            (#match? @method-name "^(describe|test|it)")
  --            arguments: (arguments [
  --              ((string) @test-name)
  --              ((template_string) @test-name)
  --            ]
  --          )))
  --        @scope-root)
  --      ]]
  --
  --      local jest = Runner:init({
  --        command = { "./node_modules/.bin/jest", "jest" },
  --        file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|coffee|ts|tsx)$",
  --        find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },
  --      }, {
  --          javascript = query,
  --          typescript = query,
  --        })
  --
  --      function jest:parse_testname(name)
  --        return name:gsub("^[\"'`]", ""):gsub("[\"'`]$", "")
  --      end
  --
  --      function jest:build_test_args(args, tests)
  --        table.insert(args, "-t")
  --        table.insert(args, "^" .. table.concat(tests, " ") .. "$")
  --        -- log.info('build_test_args -> args', vim.inspect(args));
  --        -- log.info('build_test_args -> tests', vim.inspect(tests));
  --      end
  --
  --      require('nvim-test').setup({
  --        runners = {               -- setup tests runners
  --          cs = "nvim-test.runners.dotnet",
  --          go = "nvim-test.runners.go-test",
  --          haskell = "nvim-test.runners.hspec",
  --          javacriptreact = "nvim-test.runners.jest",
  --          javascript = "nvim-test.runners.jest",
  --          lua = "nvim-test.runners.busted",
  --          python = "nvim-test.runners.pytest",
  --          ruby = "nvim-test.runners.rspec",
  --          rust = "nvim-test.runners.cargo-test",
  --          typescript = jest,
  --          typescriptreact = jest,
  --          -- typescript = "nvim-test.runners.jest",
  --          -- typescriptreact = "nvim-test.runners.jest",
  --        }
  --      })
  --    end
  --  }

  -- }}}

  -- Marks management
  -- {{{
  "MattesGroeger/vim-bookmarks",
  {
    "khanghoang/telescope-vim-bookmarks.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.vim_bookmark")
    end,
  },
  -- }}}

  -- Fold
  -- {{{
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("plugins.statuscol")
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("plugins.fold")
    end,
  },
  -- }}}
  --

  -- Starlark
  -- {{{
  "cappyzawa/starlark.vim",
  -- }}}

  -- Copilot
  -- {{{
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          fugitive = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  },
})
