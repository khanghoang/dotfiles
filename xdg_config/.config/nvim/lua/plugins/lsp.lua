local nvim_lsp = require('lspconfig')

-- TODO: CONSIDER TO REFACOTR THIS BY USING
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L306
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local function setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'ga', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('v', 'ga', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', 'D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "gp", "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap('n', 'gD', ":vsp<cr><cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap('n', 'cd', "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  buf_set_keymap('n', 'cd', "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  buf_set_keymap('n', 'gs', ":lua vim.lsp.buf.signature_help()<CR>", opts)
  -- edit = '<C-c>o',
  -- vsplit = '<C-c>v',
  -- split = '<C-c>i',
  -- tabe = '<C-c>t',
  -- quit = 'q',
  buf_set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  buf_set_keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<CR>", opts)
  buf_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)
  buf_set_keymap('n', 'll', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- almost never used
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  setup()

  -- setup vim aerial
  local require_aerial_ok, aerial = pcall(require, 'aerial')
  if require_aerial_ok then
    require("aerial").on_attach(client, bufnr)
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = "»",
    spacing = 4,
  },
  signs = true,
  update_in_insert = false,
}
)

local lsp_install_path = vim.env.HOME .. '/.local/share/nvim/mason/bin'

-- TypeScript
-- LspInstall typescript
local typescript_bin = lsp_install_path .. '/typescript-language-server'
nvim_lsp.tsserver.setup({
  cmd = { typescript_bin, '--stdio' },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
})

local pyright_bin = lsp_install_path .. '/pyright-langserver'
nvim_lsp.pyright.setup({
  cmd = vim.lsp.rpc.connect('127.0.0.1', '2704'),
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
        logLevel = 'Trace'
      },
    },
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
})

-- LUA
-- LspInstall lua
local sumneko_binary = lsp_install_path .. '/lua-language-server'
nvim_lsp.sumneko_lua.setup {
  cmd = { sumneko_binary };
  settings = {
    Lua = {
      -- Insert your settings here
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim', 'use' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
}

-- unfinished config
local gopls = lsp_install_path .. '/go'
local gopls_path = gopls .. '/gopls'
nvim_lsp.gopls.setup({
  cmd = { gopls_path, "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
})

-- JSON
-- LspInstall json
-- yarn global add vscode-langservers-extracted
local jsonls = lsp_install_path .. '/vscode-json-language-server'
nvim_lsp.jsonls.setup {
  cmd = { jsonls, '--stdio' },
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end
    }
  },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- Tailwindcss
local tailwind = lsp_install_path ..
    '/tailwindcss-language-server'
nvim_lsp.tailwindcss.setup {
  cmd = { tailwind, '--stdio' },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- Docker
local docker = lsp_install_path .. '/docker-langserver'
nvim_lsp.dockerls.setup {
  cmd = { docker, '--stdio' },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

nvim_lsp.ltex.setup({
  cmd = {'ltex-ls'},
  filetypes = {'markdown'},
  root_dir = nvim_lsp.util.find_git_ancestor,
  settings = {
    ltex = {
      enabled = {'markdown'},
      checkFrequency = 'save',
      language = 'en-US',
      diagnosticSeverity = 'information',
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = 'en-US',
      },
      dictionary = {},
      disabledRules = {
        ['en-US'] = {'EN_QUOTES'},
      },
      hiddenFalsePositives = {},
    },
  },

  on_attach = on_attach,
  capabilities = capabilities,
  flags = {debounce_text_changes = 150}
})

-- Markdown
-- LspInstall markdown marksman
-- local markdown = lsp_install_path..'/marksman/marksman'
-- nvim_lsp.marksman.setup {
--   cmd = {markdown, "server"},
--   commands = {
--     Format = {
--       function()
--         vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
--       end
--     }
--   },
--   on_attach = on_attach,
--   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }

-- Zk
require("zk").setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "select",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      on_attach = on_attach,
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})
