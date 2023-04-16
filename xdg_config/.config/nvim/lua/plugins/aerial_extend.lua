local entry_display = require("telescope.pickers.entry_display")
local finders = require("telescope.finders")
local fs_utils = require("plugins/fs_utils")
local parsers = require("nvim-treesitter.parsers")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")

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

  ---@type LanguageTree
  local parser = vim.treesitter.get_parser(bufnr, filetype)
  return parser:parse()[1], bufnr
end

local function get_functions_and_classes(file_path)
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

  return matches, bufnr

  -- local results = {}
  --
  -- for id, node, metadata in matches do
  --   local node_name_text = vim.treesitter.get_node_text(node, bufnr)
  --   table.insert(results, node_name_text)
  -- end
  --
  -- return results
end

---@param file_path string
---@param matches (fun(): integer, TSNode, TSMetadata)
---@param bufnr integer
local function parse_location(file_path, matches, bufnr)
  local lines = {}

  for id, node, metadata in matches do
    local node_name_text = vim.treesitter.get_node_text(node, bufnr)
    local node_start_row, node_start_col = node:range()
    lines[#lines + 1] = {
      path = file_path,
      lineNumber = node_start_row,
      col = node_start_col,
      preview = node_name_text,
    }
  end

  return lines
end

local function make_entry(opts)
  opts = opts or {}
  opts.tail_path = vim.F.if_nil(opts.tail_path, true)

  local displayer = entry_display.create({
    separator = "▏",
    items = {
      { width = opts.width_line or 5 },
      { width = opts.width_text or 60 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local filename
    if not opts.path_display then
      filename = entry.filename
      if opts.tail_path then
        filename = utils.path_tail(filename)
      elseif opts.shorten_path then
        filename = utils.path_shorten(filename)
      end
    end

    local line_info = { entry.lnum, "TelescopeResultsLineNr" }

    return displayer({
      line_info,
      entry.text:gsub(".* | ", ""),
      filename,
    })
  end

  return function(entry)
    return {
      valid = true,

      value = entry,
      ordinal = (not opts.ignore_filename and entry.path or "") .. " " .. entry.preview,
      display = make_display,

      filename = entry.path,
      lnum = entry.lineNumber,
      col = 1,
      text = entry.preview,
    }
  end
end

local function search(file_path)
  local matches, bufnr = get_functions_and_classes(file_path)
  local locations = parse_location(file_path, matches, bufnr)

  vim.api.nvim_buf_delete(bufnr, { force = true })

  local make_finder = function()
    if vim.tbl_isempty(locations) then
      print("Not found!")
      return
    end

    return finders.new_table({
      results = locations,
      entry_maker = make_entry({}),
    })
  end

  local initial_finder = make_finder()

  pickers
    .new({}, {
      prompt_title = "Search source graph",
      finder = initial_finder,
    })
    :find()
end

M.get_functions_and_classes = get_functions_and_classes
M.search = search

vim.api.nvim_set_keymap(
  "n",
  "<leader>ee",
  ":lua require('plugins.aerial_extend').search('/Users/khanghoang/dotfiles/xdg_config/.config/nvim/lua/plugins/specs/dummy.py')",
  {}
)

return M
