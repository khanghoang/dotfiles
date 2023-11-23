return {
  "sindrets/diffview.nvim",
  requires = "nvim-lua/plenary.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  config = true,
  keys = {
    {
      "dvo",
      "<cmd>DiffviewOpen @..master",
      desc = "[D]iff [V]iew [O]pen",
    },
    {
      "dvc",
      "<cmd>DiffviewClose<cr>",
      desc = "[D]iff [V]iew [C]lose",
    },
  },
}
