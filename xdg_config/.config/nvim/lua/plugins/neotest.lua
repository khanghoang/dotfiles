return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/neotest-plenary",
    "vim-test/vim-test", -- for lua's busted
  },
  config = function()
    require("neotest").setup({
      log_level = vim.log.levels.DEBUG,
      adapters = {
        require("neotest-plenary"),
      },
      discovery = {
        enabled = true,
      },
    })

    require("neotest").setup_project("/Users/khang/dotfiles", {
      adapters = {
        require("neotest-plenary").setup({
          min_init = "./xdg_config/.config/nvim_plugins/dbx/tests/test_init.lua",
        }),
      },
      discovery = {
        enabled = false,
      },
    })

    require("neotest").setup_project("/Users/khang/src/server", {
      adapters = {
        require("dbx"),
      },
      discovery = {
        enabled = false,
      },
    })

    require("neotest").setup_project("/Users/khang/code/server", {
      adapters = {
        require("dbx"),
      },
      discovery = {
        enabled = false,
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
      "<leader>td",
      [[<Cmd>lua require("neotest").run.run({ strategy = 'neotest-dbx-dap' })<CR>]],
      { noremap = true, desc = "[T]est [D]ebug" }
    )

    vim.api.nvim_set_keymap(
      "n",
      "<leader>tl",
      [[<Cmd>lua require("neotest").run.run_last()<CR>]],
      { noremap = true, desc = "[T]est [L]ast" }
    )

    vim.api.nvim_set_keymap(
      "n",
      "<leader>tx",
      [[<Cmd>lua require("neotest").run.stop()<CR>]],
      { noremap = true, desc = "[T]est [X]kill" }
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
  end,
}
