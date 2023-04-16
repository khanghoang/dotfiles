local nvim_lsp = require("lspconfig")

-- https://github.com/folke/neodev.nvim#%EF%B8%8F-configuration
require("neodev").setup({
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    -- plugins = { "neotest", "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  -- With lspconfig, Neodev will automatically setup your lua-language-server
  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  -- in your lsp start options
  lspconfig = false,
})

-- TODO: CONSIDER TO REFACOTR THIS BY USING
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L306
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- config for https://github.com/kevinhwang91/nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- fix issue with clangd
-- https://www.reddit.com/r/neovim/comments/wmj8kb/i_have_nullls_and_clangd_attached_to_a_buffer_c/
capabilities.offsetEncoding = "utf-8"

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
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
  buf_set_keymap("v", "ga", "<cmd>Lspsaga code_action<CR>", opts)
  -- buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap("n", "D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "gp", "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.definition({})<CR>", opts)
  buf_set_keymap("n", "cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  buf_set_keymap("n", "cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.format({ async = True})<CR>", opts)
  -- edit = '<C-c>o',
  -- vsplit = '<C-c>v',
  -- split = '<C-c>i',
  -- tabe = '<C-c>t',
  -- quit = 'q',
  buf_set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  -- buf_set_keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<CR>", opts)
  buf_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)
  -- buf_set_keymap('n', 'll', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  vim.keymap.set("n", "K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      -- choose one of coc.nvim and nvim lsp
      vim.lsp.buf.hover()
    end
  end, opts)

  -- almost never used
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )

  -- use null-ls for formatting
  local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        -- apply whatever logic you want (in this example, we'll only use null-ls)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end

  -- formatting on save, you can use this as a callback
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  setup()

  -- -- setup vim aerial
  -- local require_aerial_ok, aerial = pcall(require, 'aerial')
  -- if require_aerial_ok then
  --   require("aerial").on_attach(client, bufnr)
  -- end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "»",
      spacing = 4,
    },
    signs = true,
    update_in_insert = false,
  })

local lsp_install_path = vim.env.HOME .. "/.local/share/nvim/mason/bin"

-- TypeScript
-- LspInstall typescript
local typescript_bin = lsp_install_path .. "/typescript-language-server"
nvim_lsp.tsserver.setup({
  cmd = { typescript_bin, "--stdio" },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
})

local pyright_bin = lsp_install_path .. "/pyright-langserver"
nvim_lsp.pyright.setup({

  cmd = { pyright_bin, "--stdio" },
  -- cmd = vim.lsp.rpc.connect('127.0.0.1', '2704'),

  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        logLevel = "Trace",
      },
    },
  },
  capabilities = capabilities,
})

-- LUA
-- LspInstall lua
local sumneko_binary = lsp_install_path .. "/lua-language-server"
nvim_lsp.lua_ls.setup({
  cmd = { sumneko_binary },
  settings = {
    Lua = {
      -- Insert your settings here
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "use", "describe", "it" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  -- https://github.com/folke/neodev.nvim#%EF%B8%8F-configuration
  before_init = require("neodev.lsp").before_init,
  on_attach = on_attach,
  capabilities = capabilities,
})

-- unfinished config
local gopls = lsp_install_path
local gopls_path = gopls .. "/gopls"
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
  capabilities = capabilities,
})

local clangd = lsp_install_path
local clangd_path = clangd .. "/clangd"

capabilities =
  require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").clangd.setup({
  cmd = { clangd_path },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- JSON
-- LspInstall json
-- yarn global add vscode-langservers-extracted
local jsonls = lsp_install_path .. "/vscode-json-language-server"
nvim_lsp.jsonls.setup({
  cmd = { jsonls, "--stdio" },
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end,
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Tailwindcss
-- local tailwind = lsp_install_path ..
--     '/tailwindcss-language-server'
-- nvim_lsp.tailwindcss.setup {
--   cmd = { tailwind, '--stdio' },
--   on_attach = on_attach,
--   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
-- }

-- Docker
local docker = lsp_install_path .. "/docker-langserver"
nvim_lsp.dockerls.setup({
  cmd = { docker, "--stdio" },
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
})

nvim_lsp.ltex.setup({
  cmd = { "ltex-ls" },
  filetypes = { "markdown" },
  root_dir = nvim_lsp.util.find_git_ancestor,
  settings = {
    ltex = {
      enabled = { "markdown" },
      checkFrequency = "save",
      language = "en-US",
      diagnosticSeverity = "information",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-US",
      },
      dictionary = {},
      disabledRules = {
        ["en-US"] = { "EN_QUOTES" },
      },
      hiddenFalsePositives = {},
    },
  },

  on_attach = on_attach,
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
})

-- require("sg").setup {
--   -- Pass your own custom attach function
--   --    If you do not pass your own attach function, then the following maps are provide:
--   --        - gd -> goto definition
--   --        - gr -> goto references
--   on_attach = on_attach
-- }
--

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
      capabilities = capabilities,
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
  capabilities = capabilities,
})

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
  debug = false,
  on_attach = on_attach,
  sources = {
    -- this causes problem at vim start
    -- null_ls.builtins.code_actions.refactoring,
    -- brew install black
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.code_actions.gitsigns,
    formatting.stylua,
    formatting.google_java_format,
    -- brew install fsouza/prettierd/prettierd
    null_ls.builtins.formatting.prettierd,
    -- yarn global add eslint_d
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.mypy.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      command = "mypy-daemon",
      args = function(params)
        return {}
      end,
    }),
  },
})
