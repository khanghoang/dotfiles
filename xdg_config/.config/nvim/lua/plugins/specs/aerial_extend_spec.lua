local m = require("plugins.aerial_extend")
local mock = require("luassert.mock")
local spy = require("luassert.spy")

-- luassert https://github.com/lunarmodules/luassert
-- busted https://lunarmodules.github.io/busted/#asserts
-- test examples https://github.com/stevearc/aerial.nvim/blob/master/tests/navigation_spec.lua

local function foo(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dh", ":lua echo 'foo'", {})
  return function()
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dh", ":lua echo 'bar'", {})
  end
end

describe("aerial_extend", function()
  it("parses function and class names", function()
    -- @TODO: fix this ugly path
    local absolute_path =
      "/Users/khanghoang/dotfiles/xdg_config/.config/nvim/lua/plugins/specs/dummy.py"
    local matches, buf = m.get_functions_and_classes(absolute_path)
    local results = {}
    for id, node in matches do
      table.insert(results, vim.treesitter.get_node_text(node, buf))
    end
    assert.are.same(
      { "outside_function", "ClassFoo", "inside_function_one", "test_inside_function_two" },
      results
    )
  end)

  it("calls vim.keymap", function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dh", ":lua echo 'bar'", {})

    local s = spy.on(vim.api, "nvim_buf_set_keymap")
    local reset = foo(bufnr)
    assert.spy(s).was.called_with(bufnr, "n", "<leader>dh", ":lua echo 'foo'", {})
    reset()
    -- assert.spy(s).was.called_with(bufnr, "n", "<leader>dh", ":lua echo 'foo'", {})
  end)
end)
