require("aerial").setup({
  nerd_font = false,

  filter_kind = {
    "Class",
    "Constructor",
    -- "Constant",
    -- "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },

  icons = {
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

  backends = {
    ["_"] = { "treesitter" },
    python = { "treesitter" },
    lua = { "treesitter" },
  },
})

local map = vim.api.nvim_set_keymap
local opt = { noremap = false }

-- map('n', 'so', ':AerialToggle<CR>',opt)
-- map('n', 'do', ':call aerial#fzf()<cr>',opt)
map("n", "do", ":Telescope aerial theme=ivy previewer=false winblend=10<CR>", opt)

require("telescope").load_extension("aerial")

require("telescope").setup({
  extensions = {
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ["_"] = false, -- This key will be the default
        json = true, -- You can set the option for specific filetypes
        yaml = true,
      },
      layout_config = {
        vertical = { width = 0.5 },
        -- other layout configuration here
      },
    },
  },
})
