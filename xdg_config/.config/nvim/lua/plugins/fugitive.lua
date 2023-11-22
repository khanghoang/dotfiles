return {
  "tpope/vim-rhubarb",
  {
    "tpope/vim-fugitive",
    config = function()
      local api = vim.api

      api.nvim_set_keymap("n", "<leader>gb", ":Git blame<CR>", { noremap = true, silent = true })
      api.nvim_set_keymap("n", "<leader>gl", ":0Gclog<CR>", { noremap = true, silent = true })
      api.nvim_set_keymap("n", "<leader>gv", ":GV!<CR>", { noremap = true, silent = true })
      api.nvim_set_keymap("v", "<leader>gv", ":GV<CR>", { noremap = true, silent = true })
      api.nvim_set_keymap("n", "<leader>gc", ":Git<CR>", { noremap = true })
    end,
  },
}
