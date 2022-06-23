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
  buf_set_keymap('n', 'gD', ":vsp<cr><cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>", opts)
  buf_set_keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.lsp_dynamic_workspace_symbols()<CR>", opts)
  buf_set_keymap("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- setup vim aerial
  require("aerial").on_attach(client, bufnr)
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

local lsp_install_path = vim.env.HOME..'/.local/share/nvim/lsp_servers'

-- TypeScript
-- LspInstall typescript
local typescript_bin = lsp_install_path..'/tsserver/node_modules/typescript-language-server/lib/cli.js'
nvim_lsp.tsserver.setup({
  cmd = { typescript_bin, '--stdio' },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
})

local pyright_bin = lsp_install_path..'/python/node_modules/pyright/langserver.index.js'
nvim_lsp.pyright.setup({
  cmd = { pyright_bin, '--stdio' },
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
local sumneko_root_path = lsp_install_path..'/sumneko_lua'
local sumneko_binary = sumneko_root_path..'/extension/server/bin/lua-language-server'
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary};
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
local jsonls = lsp_install_path..'/jsonls/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server'
nvim_lsp.jsonls.setup {
  cmd = {jsonls, '--stdio'},
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- Tailwindcss
local tailwind = lsp_install_path..'/tailwindcss_npm/node_modules/@tailwindcss/language-server/bin/tailwindcss-language-server'
nvim_lsp.tailwindcss.setup {
  cmd = {tailwind, '--stdio'},
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- Docker
local docker = lsp_install_path..'/dockerfile/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver'
nvim_lsp.dockerls.setup {
  cmd = {docker, '--stdio'},
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- Markdown
-- LspInstall markdown marksman
local markdown = lsp_install_path..'/marksman/marksman'
nvim_lsp.marksman.setup {
  cmd = {markdown, "server"},
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  },
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

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
