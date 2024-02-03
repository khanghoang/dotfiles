return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-i>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        }),
        sources = {
          -- Copilot Source
          -- Copilot Source
          { name = "copilot", group_index = 2 },
          -- other sources
          { name = "nvim_lsp_signature_help", group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          -- For vsnip user.
          { name = "path", group_index = 2 },
          { name = "vsnip", group_index = 2 },
          { name = "buffer", group_index = 2 },
        },
        formatting = {
          format = function(entry, vim_item)
            local LSP_KIND_ICONS = {
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
            vim_item.kind = string.format("%s %s", LSP_KIND_ICONS[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
      })
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
}
