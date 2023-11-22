return {
  "vifm/vifm.vim",
  config = function()
    local api = vim.api

    api.nvim_set_keymap("n", "<leader>nt", ":Vifm<CR>", { noremap = true, silent = true })
  end,
}
