local fs_utils = require("plugins.fs_utils")
local parsers = require("nvim-treesitter.parsers")

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(
  bufnr,
  0,
  -1,
  false,
  vim.split(fs_utils.get_file_content("/Users/khanghoang/code/pytest-example/myapp/app.py"), "\n")
)
local parser = vim.treesitter.get_parser(bufnr, "python")
local tree = parser:parse()[1]

local query_string = [[
  (function_definition
    name: (identifier) @name
    )
  (class_definition
    name: (identifier) @name
    )
]]

local query = vim.treesitter.query.parse("python", query_string)

-- execute the query on the syntax tree
local matches = query:iter_captures(tree:root(), bufnr)

for id, node, metadata in matches do
  local name = query.captures[id] -- name of the capture in the query
  local q = require("vim.treesitter")
  print(vim.treesitter.get_node_text(node, bufnr))
end
