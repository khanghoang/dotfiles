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

local job = require("plenary.job")
local function runJob(cmd, args)
  local stdout = ""
  local stderr = ""
  job
    :new({
      command = cmd,
      args = args,
      on_stdout = function(_, data)
        stdout = stdout .. "\n" .. data
      end,
      on_stderr = function(_, data)
        stderr = stderr .. data
      end,
    })
    :sync()
  return stdout, stderr
end

local function parseJsonFromCmd(cmd, args)
  local stdout, stderr = runJob(cmd, args)
  if stderr ~= "" then
    error(stderr)
    return nil
  end

  return vim.fn.json_decode(stdout)
end

-- get input
local function querySrc()
  local query = vim.fn.input("src query: ")
  if query == nil or query == "" then
    return nil
  end
  local json = parseJsonFromCmd("src", { "search", "-json", query })
  local locations = parseLocationFromJson(json)
  sendToQuickfix(locations)
end

vim.keymap.set('n', '<leader>S', querySrc, { desc = "Search source graph" })

return {
  query = querySrc,
}
