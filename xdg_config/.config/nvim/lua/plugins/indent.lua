local indent_highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  config = function(_, opts)
    -- require("ibl").setup({
    --   indent = { char = "│" },
    --   whitespace = {
    --     remove_blankline_trail = false,
    --   },
    --   scope = { enabled = false },
    -- })
    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    vim.g.rainbow_delimiters = { highlight = indent_highlight }
    require("ibl").setup(opts)

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
  opts = {
    -- indent = { highlight = indent_highlight, char = "│" },
    indent = { char = "│" },
    scope = {
      highlight = indent_highlight,
    },
    exclude = {
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        fugitive = false,
        ["."] = false,
      },
    },
  },
}
