local m = require("plugins.aerial_extend")

-- use https://github.com/lunarmodules/luassert

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
      { "outside_function", "ClassFoo", "inside_function_one", "inside_function_two" },
      results
    )
  end)
end)
