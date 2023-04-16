local fs_utils = require("plugins/fs_utils")
local parsers = require("nvim-treesitter.parsers")
local M = {}

local function load_ts_tree_from_path(file_path)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(
    bufnr,
    0,
    -1,
    false,
    vim.split(fs_utils.get_file_content(file_path), "\n")
  )

  vim.api.nvim_buf_set_name(bufnr, file_path)

  -- get the filetype based on the file extension
  local ext = vim.fn.fnamemodify(file_path, ":e")
  -- @TODO: need to refactor this to get filetype from buffer's file name
  local filetype = "python"

  -- @type LanguageTree
  local parser = vim.treesitter.get_parser(bufnr, filetype)
  return parser:parse()[1], bufnr
end

M.get_functions_and_classes = function(file_path)
  local tree, bufnr = load_ts_tree_from_path(file_path)

  local query_string = [[
    (function_definition
      name: (identifier) @name
      )
    (class_definition
      name: (identifier) @name
      )
  ]]

  ---@type Query
  local query = vim.treesitter.query.parse("python", query_string)

  -- execute the query on the syntax tree
  local matches = query:iter_captures(tree:root(), bufnr, 0, -1)

  local results = {}

  for id, node, metadata in matches do
    local node_name_text = vim.treesitter.get_node_text(node, bufnr)
    table.insert(results, node_name_text)
  end

  return results
end

return M
