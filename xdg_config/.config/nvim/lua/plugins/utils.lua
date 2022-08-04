vim.notify = require("notify")

local M = {}

M.notify_output = function(command, opts)
  local output = ""
  local notification
  local notify = function(msg, level)
    local notify_opts = vim.tbl_extend(
      "keep",
      opts or {},
      { title = table.concat(command, " "), replace = notification }
    )
    notification = vim.notify(msg, level, notify_opts)
  end
  local on_data = function(_, data)
    output = output .. table.concat(data, "\n")
    notify(output, "info")
  end
  vim.fn.jobstart(command, {
    on_stdout = on_data,
    on_stderr = on_data,
    on_exit = function(_, code)
      if #output == 0 then
        notify("No output of command, exit code: " .. code, "warn")
      end
    end,
  })
end

M.openNearestFile = function (file)
  -- default param https://riptutorial.com/lua/example/4081/default-parameters
  file = file or "package.json" -- why "package.json"? idk
  local Path = require"plenary.path"
  local p = Path:new { vim.api.nvim_buf_get_name(0) };
  local parents = p:parents()

  -- print(parents)

  -- https://github.com/ericlacerda/nvim/blob/6dd2d2cf76ed2cd9bedcb70bb023ed2cb9e9c273/plugged/plenary.nvim/tests/plenary/path_spec.lua#L585
  for _, parent in pairs(parents) do
    -- print(parent)
    -- @TODO: use :joinpath
    local x = parent..'/'.. file
    -- print(x)
    local exists = Path.new(x):exists()
    -- print(exists)
    if exists then
      print('found '.. x)
      vim.api.nvim_command('e'..x)
    end
  end
  -- package.json not found
end

vim.keymap.set('n', '<leader>rb', ":lua require('plugins/utils').openNearestFile()<CR>")

vim.api.nvim_create_user_command("OpenNearestPackageJSON", function(opts)
  require('plugins/utils').openNearestPackageJSON()
end, {
    desc = "Install one or more packages.",
    nargs = "+",
    complete = "custom,v:lua.mason_completion.available_package_completion",
  })

vim.api.nvim_set_keymap('n', '<leader><leader>r', ":lua require('plugins.utils').reload()<CR>", { noremap = true })

M.get_visual_selection = function ()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

M.test = function ()
  local s = M.get_visual_selection()
  vim.notify(s)
end

vim.api.nvim_set_keymap('v', '<leader>T', ":lua require('plugins.utils').test()<CR>", { noremap = true })

M.reload = function ()
  require("plenary.reload").reload_module("plugins.utils")
  require("plugins.utils")
  print('reloaded')
end

return M
