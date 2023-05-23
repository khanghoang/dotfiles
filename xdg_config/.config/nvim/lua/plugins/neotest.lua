require("neotest").setup({
  adapters = {
    require('plugins.dbx'),
    -- require("neotest-plenary"),
  },
  -- log_level = vim.log.levels.DEBUG,
  discovery = {
    concurrent = 1,
    enabled = false,
  },
  ["/Users/khang/src/server"] = {
    adapters = {
      require('plugins.dbx'),
    },
    discovery = {
      enabled = false,
    },
  },
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>tr",
  [[<Cmd>lua require("neotest").run.run()<CR>]],
  { noremap = true, desc = "[T]est [R]un" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>tf",
  [[<Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>]],
  { noremap = true, desc = "[T]est [F]ile" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>to",
  [[<Cmd>lua require("neotest").output_panel.open()<CR>]],
  { noremap = true, desc = "[T]est [O]pen" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ts",
  [[<Cmd>lua require("neotest").summary.toggle()<CR>]],
  { noremap = true, desc = "[T]est [S]ummary" }
)
