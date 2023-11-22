return {
  "mickael-menu/zk-nvim",
  config = function()
    require("zk").setup({
      -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
      -- it's recommended to use "telescope" or "fzf"
      picker = "select",
      lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start_client()`
        },
        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    })

    -- https://github.com/mickael-menu/zk-nvim#example-mappings
    local opts = { noremap = true, silent = false }

    -- Create a new note after asking for its title.
    -- Conflicted with the ft one
    vim.api.nvim_set_keymap(
      "n",
      "<leader>zn",
      "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
      opts
    )

    -- integrate with telescope
    require("telescope").load_extension("zk")

    -- Open notes.
    vim.api.nvim_set_keymap("n", "<leader>zo", ":Telescope zk notes<CR>", opts)
    -- Open notes associated with the selected tags.
    vim.api.nvim_set_keymap("n", "<leader>zt", ":Telescope zk tags<CR>", opts)

    -- Search for the notes matching a given query.
    vim.api.nvim_set_keymap(
      "n",
      "<leader>zf",
      "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>",
      opts
    )
    -- Search for the notes matching the current visual selection.
    vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
    vim.api.nvim_set_keymap(
      "n",
      "<leader>zn",
      "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: '), datetime = 'today' }<CR>",
      opts
    )
  end,
}
