local parsers = require("nvim-treesitter.parsers")
-- local query = require("nvim-treesitter.query")

-- local lua_code = [[
--   local function foo(x)
--     print(x)
--   end
-- ]]

local bufnr = vim.api.nvim_create_buf(false, true)
-- split lua_code into lines
-- local lines = vim.split(lua_code, "\n")
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  "def hello():",
  "  print('Hello, world!')",
})
print(vim.inspect(bufnr))

-- vim.treesitter.highlighter.new(bufnr, "python"):update()

local parser = vim.treesitter.get_parser(bufnr, "python")
local tree = parser:parse()[1]

local query_string = [[
(function_definition
  name: (identifier) @name
  (#set! "kind" "Function")
  ) @type
]]

local query = vim.treesitter.query.parse("python", query_string)

-- execute the query on the syntax tree
local matches = query:iter_captures(tree:root(), bufnr)

-- create a table to store the function names
local function_names = {}

for id, node, metadata in matches do
  local name = query.captures[id] -- name of the capture in the query
  local q = require("vim.treesitter")
  print(vim.treesitter.get_node_text(node, bufnr))
  print(vim.treesitter.get_node_text(node:named_child(1), bufnr))
end

print(vim.inspect(function_names))
