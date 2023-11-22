local entry_display = require("telescope.pickers.entry_display")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local fs_utils = require("plugins.fs_utils")
local log = require("plugins.log")
local make_entry = require("telescope.make_entry")
local vim_utils = require("plugins.vim_utils")

local utils = require("telescope.utils")

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local function parseLocationFromJson(json)
  if json.Results == nil then
    return {}
  end

  local lines = {}
  for _, result in ipairs(json.Results) do
    if result.__typename ~= "FileMatch" then
      goto continue
    end
    local file = result.file
    local lineMatches = result.lineMatches
    -- matched just the file name
    if #lineMatches == 0 then
      lines[#lines + 1] = {
        path = "/Users/khang/code/server/" .. file.path,
        lineNumber = 1,
        col = 1,
        preview = "Filename match: " .. file.name,
      }
      goto continue
    end
    -- matched some lines in a file
    for _, lineMatch in ipairs(lineMatches) do
      local offsetAndLengths = lineMatch.offsetAndLengths
      local col = 1
      local lastCol = 0
      if offsetAndLengths ~= nil then
        local maybeCol = offsetAndLengths[1][1]
        local maybeLastCol = offsetAndLengths[1][2]
        if type(maybeCol) == "number" then
          col = maybeCol + 1
          lastCol = maybeLastCol + 1
        end
      end
      lines[#lines + 1] = {
        path = "/Users/khang/code/server/" .. file.path,
        lineNumber = lineMatch.lineNumber + 1,
        col = col,
        end_col = lastCol,
        preview = lineMatch.preview,
      }
    end
    ::continue::
  end
  return lines
end

-- send to quickfix
local function sendToQuickfix(lines)
  local items = {}
  for _, line in ipairs(lines) do
    items[#items + 1] = {
      filename = line.path,
      lnum = line.lineNumber,
      col = line.col,
      text = line.preview,
    }
  end
  vim.fn.setqflist(items)
  vim.cmd(":copen")
end

local function parseJsonFromCmd(cmd, args)
  local stdout, stderr = vim_utils.run_job(cmd, args)
  if stderr ~= "" then
    error(stderr)
    return nil
  end

  return vim_utils.json_decode(stdout)
end

-- local function make_entry_from_bookmarks(opts)
--     opts = opts or {}
--     opts.tail_path = vim.F.if_nil(opts.tail_path, true)
--
--     local displayer = entry_display.create {
--         separator = "▏",
--         items = {
--             { width = opts.width_line or 5 },
--             { width = opts.width_text or 60 },
--             { remaining = true }
--         }
--     }
--
--     local make_display = function(entry)
--         local filename
--         if not opts.path_display then
--             filename = entry.filename
--             if opts.tail_path then
--                 filename = utils.path_tail(filename)
--             elseif opts.shorten_path then
--                 filename = utils.path_shorten(filename)
--             end
--         end
--
--         local line_info = {entry.lnum, "TelescopeResultsLineNr"}
--
--         return displayer {
--             line_info,
--             entry.text:gsub(".* | ", ""),
--             filename,
--         }
--     end
--
--     return function(entry)
--         return {
--             valid = true,
--
--             value = entry,
--             ordinal = (
--             not opts.ignore_filename and filename
--             or ''
--             ) .. ' ' .. entry.text,
--             display = make_display,
--
--             filename = entry.filename,
--             lnum = entry.lnum,
--             col = 1,
--             text = entry.text,
--         }
--     end
--
-- end

local function make_entry_from_sg_cli_results(opts)
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

-- get input
local function querySrc()
  local query = vim.fn.input({ prompt = "Search sourcegrap: " })
  -- vim.ui.input({ prompt = 'Search sourcegraph: ' }, function(input)
  --   query = input
  -- end)

  if query == nil or query == "" then
    return nil
  end

  local json = parseJsonFromCmd("src", { "search", "-json", query })
  local locations = parseLocationFromJson(json)

  local make_finder = function()
    if vim.tbl_isempty(locations) then
      print("Not found!")
      return
    end

    return finders.new_table({
      results = locations,
      entry_maker = make_entry_from_sg_cli_results(opts or {}),
    })
  end

  local initial_finder = make_finder()

  local p = string.format("%s/source_graph", vim.api.nvim_call_function("stdpath", { "cache" }))
  if not fs_utils.is_dir(p) then
    fs_utils.mkdir(p)
  end

  -- make file
  local outfile =
    string.format("%s/source_graph/%s", vim.api.nvim_call_function("stdpath", { "cache" }), query)
  fs_utils.write_file(outfile, json, "a")

  pickers
    .new({}, {
      prompt_title = "Search source graph",
      finder = initial_finder,
      previewer = conf.qflist_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>S", querySrc, { desc = "Search source graph" })

return {
  query = querySrc,
}
