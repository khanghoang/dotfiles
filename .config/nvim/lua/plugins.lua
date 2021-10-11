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

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args)
            -- For `vsnip` user.
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-k'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'nvim_lsp' },
          -- For vsnip user.
          { name = 'vsnip' },
          { name = 'buffer' },
        }
      })
    end,
    requires = {'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'neovim/nvim-lspconfig'}

  }

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

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
    ft = {'typescriptreact', 'typescript'},
  }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use {
    'nvim-treesitter/playground',
    cmd = {'TSPlaygroundToggle'}
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require'nvim-treesitter.configs'.setup {
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

              -- Or you can define your own textobjects like this
              ["iF"] = {
                python = "(function_definition) @function",
                typescriptreact = "(function_definition) @function",
              },
            },
          },
        },
      }
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Misc
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'simrat39/symbols-outline.nvim'
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
    opt = true,
    cmd = {'VimspectorContinue'}
  }

  -- Vim async dispatch
  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    -- event = { 'VimEnter' },
    config = function()
       require('plugins.lightline')
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'glepnir/lspsaga.nvim'

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
    'rhysd/accelerated-jk',
    opt = true
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



end)

