local M = {}

local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local telescope = require("telescope")

-- read file content
local function read_file(file)
  local f = io.open(file, "rb")
  if not f then
    return ""
  end

  local content = f:read("*all")
  f:close()
  return content
end

local ext_config = {
  show_nesting = {
    ["_"] = false,
    json = true,
    yaml = true,
  },
}

local function aerial_picker(opts)
  opts = opts or {}
  require("aerial").sync_load()
  local backends = require("aerial.backends")
  local config = require("aerial.config")
  local data = require("aerial.data")
  local highlight = require("aerial.highlight")
  local util = require("aerial.util")

  local file_path = "/Users/khanghoang/code/pytest-example/myapp/app.py"
  local bufnr = vim.api.nvim_create_buf(false, true)
  print(bufnr)
  local content = read_file(file_path)

  -- break up the file into lines
  local lines = vim.split(content, "\n")
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  -- vim.api.nvim_buf_set_name(bufnr, file_path)

  local filename = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local show_nesting = ext_config.show_nesting[filetype]
  if show_nesting == nil then
    show_nesting = ext_config.show_nesting["_"]
  end
  local backend = backends.get()

  if not backend then
    backends.log_support_err()
    return
  elseif not data.has_symbols(bufnr) then
    backend.fetch_symbols_sync(bufnr, opts)
    print(vim.inspect(data.has_symbols(bufnr)))
  end

  local displayer = opts.displayer
    or entry_display.create({
      separator = " ",
      items = {
        { width = 4 },
        { width = 30 },
        { remaining = true },
      },
    })

  local function make_display(entry)
    local item = entry.value
    local icon = config.get_icon(bufnr, item.kind)
    local text = vim.api.nvim_buf_get_lines(bufnr, item.lnum - 1, item.lnum, false)[1] or ""
    text = vim.trim(text)
    local icon_hl = highlight.get_highlight(item, true) or "NONE"
    local name_hl = highlight.get_highlight(item, false) or "NONE"
    local columns = {
      { icon, icon_hl },
      { entry.name, name_hl },
      text,
    }
    return displayer(columns)
  end

  local function make_entry(item)
    local name = item.name
    if opts.get_entry_text ~= nil then
      name = opts.get_entry_text(item)
    else
      if show_nesting then
        local cur = item.parent
        while cur do
          name = string.format("%s.%s", cur.name, name)
          cur = cur.parent
        end
      end
    end
    return {
      value = item,
      display = make_display,
      name = name,
      ordinal = name .. " " .. string.lower(item.kind),
      lnum = item.lnum,
      col = item.col + 1,
      filename = filename,
    }
  end

  local results = {}
  local default_selection_index = 1
  if data.has_symbols(bufnr) then
    local bufdata = data.get_or_create(bufnr)
    local position = bufdata.positions[bufdata.last_win]
    for _, item in bufdata:iter({ skip_hidden = false }) do
      table.insert(results, item)
      if item == position.closest_symbol then
        default_selection_index = #results
      end
    end
  end

  -- Reverse the symbols so they have the same top-to-bottom order as in the file
  util.tbl_reverse(results)
  default_selection_index = #results - (default_selection_index - 1)
  -- pickers
  --   .new(opts, {
  --     prompt_title = "Document Symbols",
  --     finder = finders.new_table({
  --       results = results,
  --       entry_maker = make_entry,
  --     }),
  --     default_selection_index = default_selection_index,
  --     sorter = conf.generic_sorter(opts),
  --     previewer = conf.qflist_previewer(opts),
  --   })
  --   :find()

  vim.api.nvim_buf_delete(bufnr, { force = true })
end

M.aerial = aerial_picker

vim.g.aerial_picker = aerial_picker

aerial_picker()

-- ["ctrl-q"] = function('s:build_quickfix_list'),
vim.g.fzf_action = {
  ["ctrl-t"] = "tab split",
  ["ctrl-s"] = "split",
  ["ctrl-v"] = "vsplit",
  ["ctrl-f"] = aerial_picker,
}

return M
