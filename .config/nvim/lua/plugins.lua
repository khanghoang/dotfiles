
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes
  use 'mhartington/oceanic-next'

  -- Navigation
  use 'vifm/vifm.vim'
  use 'rbgrouleff/bclose.vim'
  use 'easymotion/vim-easymotion'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'

  use {
    'pantharshit00/vim-prisma',
    ft = {"prisma"}
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true -- defaults to false
      }

      vim.api.nvim_set_keymap('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<C-\\>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", { noremap = true, silent = true })
    end
  }

  use {
    'nvim-lua/lsp-status.nvim',
    config = function()
      local lsp_status = require("lsp-status")
      local LSP_KIND_SIGNS = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      lsp_status.config({
        kind_labels = LSP_KIND_SIGNS,
        status_symbol = "",
        diagnostics = false,
      })
      lsp_status.register_progress()
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)
            require'luasnip'.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end
        }),
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          -- For vsnip user.
          { name = 'path' },
          { name = 'vsnip' },
          { name = 'buffer' },
        },
        formatting = {
          format = function(entry, vim_item)
            local LSP_KIND_ICONS = {
              Text = '  ',
              Method = '  ',
              Function = '  ',
              Constructor = '  ',
              Field = '  ',
              Variable = '  ',
              Class = '  ',
              Interface = '  ',
              Module = '  ',
              Property = '  ',
              Unit = '  ',
              Value = '  ',
              Enum = '  ',
              Keyword = '  ',
              Snippet = '  ',
              Color = '  ',
              File = '  ',
              Reference = '  ',
              Folder = '  ',
              EnumMember = '  ',
              Constant = '  ',
              Struct = '  ',
              Event = '  ',
              Operator = '  ',
              TypeParameter = '  ',
            }
            vim_item.kind = string.format("%s %s", LSP_KIND_ICONS[vim_item.kind], vim_item.kind)
            return vim_item
          end
        },
      })
    end,
    requires = {'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'neovim/nvim-lspconfig'}

  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use {
    'L3MON4D3/LuaSnip',
    config = function ()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/khanghoang/.config/nvim/lua/snippets/vscode-jest-snippets" }})
      local ls = require('luasnip');

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
    end
  }

  -- Git support
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
      end
      require('gitsigns').setup {
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,

          ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
          ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
      }
    end
  }

  -- Language support
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  use {
    'tree-sitter/tree-sitter-typescript',
    ft = {'typescriptreact', 'typescript', 'javascript', 'javascriptreact'},
  }

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {
    'nvim-treesitter/nvim-treesitter-refactor',
  }
  use {
    'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle'}
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require'nvim-treesitter.configs'.setup {
        matchup = {
          enable = true,
        },
        ensure_installed = {'javascript', 'lua', 'bash', 'go', 'json', 'typescript', 'python'},
        highlight = {
          enable = true
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
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
          },
        },
        indent = {
          enable = true
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
              ['uc'] = '@comment.outer',

              -- -- Or you can define your own textobjects like this
              ["iF"] = {
                -- python = "(function_definition) @function",
                typescriptreact = "(function_definition) @function",
              },
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
      }

      -- fix fold on typescriptreact
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.typescript.used_by = "typescriptreact"

      -- fold
      vim.cmd [[set foldmethod=expr]]
      vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
      -- this will fold EVERYTHINGGG!!!
      -- vim.cmd [[set foldlevel=1000]]
      -- disable auto fold when opening file
      vim.cmd [[set nofoldenable]]
    end
  }

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Misc
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'christoomey/vim-tmux-navigator'
  use 'tomtom/tcomment_vim'
  use 'frankier/neovim-colors-solarized-truecolor-only'

  -- Tig in vim
  use {
    'iberianpig/tig-explorer.vim',
    opt = true,
    cmd = {'Tig'}
  }

  -- Vimspector
  use {
    'puremourning/vimspector',
    -- opt = true,
    -- cmd = {'VimspectorContinue'},
    config = function ()
      local map = vim.api.nvim_set_keymap
      local opt = {noremap = false}

      map('n', '<leader>dd', ':call vimspector#Launch()<CR>',opt)
      map('n', '<leader>de', ':call vimspector#Reset()<CR>',opt)
      map('n', '<leader>dr', ':call vimspector#Restart()<CR>',opt)

      map('n', '<leader>dl', ':call vimspector#StepInto()<CR>',opt)
      map('n', '<leader>dh', ':call vimspector#StepOut()<CR>',opt)
      map('n', '<leader>dj', ':call vimspector#StopOver()<CR>',opt)
      map('n', '<leader>dc', ':call vimspector#Continue()<CR>',opt)
      map('n', '<leader>drc', '<Plug>VimspectorRunToCursor',opt)
      map('n', '<leader>dbp', '<Plug>VimspectorToggleBreakpoint',opt)
    end
  }

  -- Vim async dispatch
  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }

  use {
    'NTBBloodbath/galaxyline.nvim',
    -- branch = 'main',
    -- event = { 'VimEnter' },
    config = function()
      require('plugins.lightline')
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use {
    'tami5/lspsaga.nvim',
    -- branch = 'nvim6.0'
    branch = 'main'
  }

  use {
    'folke/trouble.nvim',
    config = function ()
      local map = vim.api.nvim_set_keymap
      local opt = {noremap = false}

      map('n', 'tt', ':TroubleToggle<CR>',opt)
    end
  }

  use {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup({
        nerd_font = false,

        filter_kind = {
          "Class",
          "Constructor",
          "Constant",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
        },

        icons = {
          Text = '  ',
          Method = '  ',
          Function = '  ',
          Constructor = '  ',
          Field = '  ',
          Variable = '  ',
          Class = '  ',
          Interface = '  ',
          Module = '  ',
          Property = '  ',
          Unit = '  ',
          Value = '  ',
          Enum = '  ',
          Keyword = '  ',
          Snippet = '  ',
          Color = '  ',
          File = '  ',
          Reference = '  ',
          Folder = '  ',
          EnumMember = '  ',
          Constant = '  ',
          Struct = '  ',
          Event = '  ',
          Operator = '  ',
          TypeParameter = '  ',
        },

        -- Customize the characters used when show_guides = true
        guides = {
          -- When the child item has a sibling below it
          mid_item = "├─",
          -- When the child item is the last in the list
          last_item = "└─",
          -- When there are nested child guides to the right
          nested_top = "│ ",
          -- Raw indentation
          whitespace = "  ",
        },

        backends = { "lsp", "treesitter", "markdown" },

      })
      local map = vim.api.nvim_set_keymap
      local opt = {noremap = false}

      map('n', 'so', ':AerialToggle<CR>',opt)
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    branch = 'master',
    config = function()
      vim.g.indent_blankline_char = "│"
      vim.g.indent_blankline_show_first_indent_level = true
      vim.g.indent_blankline_filetype_exclude = {
        "startify",
        "dashboard",
        "dotooagenda",
        "log",
        "fugitive",
        "gitcommit",
        "packer",
        "vimwiki",
        "markdown",
        "json",
        "txt",
        "vista",
        "help",
        "todoist",
        "NvimTree",
        "peekaboo",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "" -- for all buffers without a file type
      }
      vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_context_patterns = {
        "abstract_class_declaration", "abstract_method_signature",
        "accessibility_modifier", "ambient_declaration", "arguments", "array",
        "array_pattern", "array_type", "arrow_function", "as_expression",
        "asserts", "assignment_expression", "assignment_pattern",
        "augmented_assignment_expression", "await_expression",
        "binary_expression", "break_statement", "call_expression",
        "call_signature", "catch_clause", "class", "class_body",
        "class_declaration", "class_heritage", "computed_property_name",
        "conditional_type", "constraint", "construct_signature",
        "constructor_type", "continue_statement", "debugger_statement",
        "declaration", "decorator", "default_type", "do_statement",
        "else_clause", "empty_statement", "enum_assignment", "enum_body",
        "enum_declaration", "existential_type", "export_clause",
        "export_specifier", "export_statement", "expression",
        "expression_statement", "extends_clause", "finally_clause",
        "flow_maybe_type", "for_in_statement", "for_statement",
        "formal_parameters", "function", "function_declaration",
        "function_signature", "function_type", "generator_function",
        "generator_function_declaration", "generic_type", "if_statement",
        "implements_clause", "import", "import_alias", "import_clause",
        "import_require_clause", "import_specifier", "import_statement",
        "index_signature", "index_type_query", "infer_type",
        "interface_declaration", "internal_module", "intersection_type",
        "jsx_attribute", "jsx_closing_element", "jsx_element", "jsx_expression",
        "jsx_fragment", "jsx_namespace_name", "jsx_opening_element",
        "jsx_self_closing_element", "labeled_statement", "lexical_declaration",
        "literal_type", "lookup_type", "mapped_type_clause",
        "member_expression", "meta_property", "method_definition",
        "method_signature", "module", "named_imports", "namespace_import",
        "nested_identifier", "nested_type_identifier", "new_expression",
        "non_null_expression", "object", "object_assignment_pattern",
        "object_pattern", "object_type", "omitting_type_annotation",
        "opting_type_annotation", "optional_parameter", "optional_type", "pair",
        "pair_pattern", "parenthesized_expression", "parenthesized_type",
        "pattern", "predefined_type", "primary_expression", "program",
        "property_signature", "public_field_definition", "readonly_type",
        "regex", "required_parameter", "rest_pattern", "rest_type",
        "return_statement", "sequence_expression", "spread_element",
        "statement", "statement_block", "string", "subscript_expression",
        "switch_body", "switch_case", "switch_default", "switch_statement",
        "template_string", "template_substitution", "ternary_expression",
        "throw_statement", "try_statement", "tuple_type",
        "type_alias_declaration", "type_annotation", "type_arguments",
        "type_parameter", "type_parameters", "type_predicate",
        "type_predicate_annotation", "type_query", "unary_expression",
        "union_type", "update_expression", "variable_declaration",
        "variable_declarator", "while_statement", "with_statement",
        "yield_expression"
      }
      -- because lazy load indent-blankline so need readd this autocmd
      vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
    end,
  }

  use {
    'itchyny/vim-cursorword',
    event = {'BufReadPre','BufNewFile'},
    config = function()
      vim.api.nvim_command('augroup user_plugin_cursorword')
      vim.api.nvim_command('autocmd!')
      vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0')
      vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
      vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
      vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
      vim.api.nvim_command('augroup END')
    end,
  }

  use {
    'hrsh7th/vim-eft',
    opt = true,
    config = function()
      vim.g.eft_ignorecase = true
    end
  }

  use {
    'kana/vim-operator-replace',
    keys = {{'x','p'}},
    config = function()
      vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
    end,
    requires = 'kana/vim-operator-user'
  }

  use {
    'rhysd/vim-operator-surround',
    event = 'BufRead',
    requires = 'kana/vim-operator-user'
  }

  use {
    'kana/vim-niceblock',
    opt = true
  }

  use {
    'Raimondi/delimitMate',
    event = 'InsertEnter',
    config = function()
      vim.g.delimitMate_expand_cr = 0
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_smart_quotes = 1
      vim.g.delimitMate_expand_inside_quotes = 0
      vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    ft = { 'html','css','sass','vim','typescript','typescriptreact'},
    config = function()
      require 'colorizer'.setup {
        css = { rgb_fn = true; };
        scss = { rgb_fn = true; };
        sass = { rgb_fn = true; };
        stylus = { rgb_fn = true; };
        vim = { names = true; };
        tmux = { names = false; };
        'javascript';
        'javascriptreact';
        'typescript';
        'typescriptreact';
        html = {
          mode = 'foreground';
        }
      }
    end
  }

  use {
    'kdheepak/tabline.nvim',
    config = function()
      require'tabline'.setup {
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          section_separators = {'|', '|'},
          component_separators = {'|', '|'},
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
          show_devicons = false, -- this shows devicons in buffer section
          show_bufnr = false, -- this appends [bufnr] to buffer section,
          show_filename_only = true, -- shows base filename only instead of relative path in filename
        }
      }

      vim.cmd[[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]

      require'lualine'.setup {
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { require'tabline'.tabline_buffers },
          lualine_x = { require'tabline'.tabline_tabs },
          lualine_y = {},
          lualine_z = {},
        },
      }

    end,
    requires = { { 'nvim-lualine/lualine.nvim'}, {'kyazdani42/nvim-web-devicons', opt = true} }
  }

  use 'godlygeek/tabular'

  use {
    '~/code/dotfiles/neovim-plugins/obsidian.nvim',
    config = function ()
      local api = vim.api

      require('obsidian').setup({
        directory = '~/thoughts/brain'
      })

      api.nvim_set_keymap('n', '<leader>zn', ':Capture ', {noremap = true})
      api.nvim_set_keymap('n', '<leader>zs', ':Screenshot<CR>', {noremap = true})
      api.nvim_set_keymap('n', '<leader>zi', ':LinkNote<CR>', {noremap = true})
    end
  }

  use {
    "rcarriga/neotest",
    -- "~/code/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- disable due to a weird error about duplicated function declaration
      "antoinemadec/FixCursorHold.nvim",
      "vim-test/vim-test",
      "rcarriga/neotest-vim-test",
      -- local dev
      -- '~/code/neotest-vim-test',
      "rcarriga/neotest-plenary",
    },
    config = function ()
      local g = vim.g
      -- in millisecond, used for both CursorHold and CursorHoldI,
      -- use updatetime instead if not defined
      g.cursorhold_updatetime = 100

      require("neotest").setup({
        adapters = {
          require("neotest-vim-test")({ ignore_filetypes = { "python", "lua" } }),
          -- why do we need this???
          -- require("neotest-plenary")
        }
      })

      -- disable for testing
      -- g["test#javascript#runner"] = 'jest'
      -- g["test#typescript#runner"] = 'jest'
      -- g["test#strategy"] = 'dispatch_background'

      -- usage: 
      -- 1. Run test (for example :TestNearest)
      -- 2. <C-o> to scroll through the test results
      -- 3. <C-o> on the failed test LOC to open it in vim
      vim.cmd[[tmap <C-o> <C-\><C-n>]]

      vim.api.nvim_set_keymap('n', '<leader>tn', ":TestNearest<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>tf', ":TestNearest<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>ts', ":TestNearest<CR>", {noremap = true})
      vim.api.nvim_set_keymap('n', '<leader>tl', ":TestLast<CR>", {noremap = true})
    end
  }

  -- Generate table of content from a markdown file
  -- use {
  --   'mzlogin/vim-markdown-toc',
  --   ft = {'markdown'},
  --   opt = true,
  --   cmd = {'GenTocGFM'}
  -- }
  use {
    'preservim/vim-markdown',
    ft = {'markdown'},
  }

end)
