local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {noremap = true, silent = true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gs', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
  buf_set_keymap('v', 'ga', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
  buf_set_keymap('n', 'D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "gp", "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>", opts)
  buf_set_keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<CR>", opts)
  buf_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
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

local lsp_install_path = vim.env.HOME..'/.local/share/nvim/lspinstall'

-- TypeScript
-- LspInstall typescript
local typescript_bin = lsp_install_path..'/typescript/node_modules/typescript-language-server/lib/cli.js'
nvim_lsp.tsserver.setup({
  cmd = { typescript_bin, '--stdio' },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
})

nvim_lsp.pyright.setup({
  cmd = { "pyright-langserver", "--stdio", '--stats', '--verbose'},
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
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

-- LUA
-- LspInstall lua
local sumneko_root_path = lsp_install_path..'/lua'
local sumneko_binary = sumneko_root_path..'/sumneko-lua-language-server'
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/sumneko-lua/extension/server/main.lua"};
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
        globals = {'vim', 'use'},
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
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

local gopls = lsp_install_path..'/go'
local gopls_path = gopls..'/gopls'
nvim_lsp.gopls.setup({
  cmd = {gopls_path, "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

-- JSON
-- LspInstall json
-- yarn global add vscode-langservers-extracted
nvim_lsp.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
