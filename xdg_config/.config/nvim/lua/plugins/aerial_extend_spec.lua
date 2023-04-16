local m = require("plugins.aerial_extend")

-- use https://github.com/lunarmodules/luassert

describe("aerial_extend", function()
  it("should be easy to use", function()
    assert.truthy("Yup.")
  end)

  it("parses function and class names", function()
    local results = m.get_functions_and_classes()
    assert.are.same({"outside_function", "ClassFoo", "inside_function_one", "inside_function_two" }, results)
  end)
end)
