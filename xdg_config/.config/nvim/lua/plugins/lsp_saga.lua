return {
  "glepnir/lspsaga.nvim",
  -- branch = 'nvim6.0'
  lazy = true,
  branch = "main",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
        sign_priority = 0,
        virtual_text = true,
      },
    })
  end,
  dependencies = {
    { "kyazdani42/nvim-web-devicons" },
    --Please make sure you install markdown and markdown_inline parser
    { "nvim-treesitter/nvim-treesitter" },
  },
}
