-- Need to symlink since neotest looks for plugins side its "strategies" dir
-- ln -sf /Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/neotest-dbx-dap /Users/khang/.local/share/nvim/site/pack/packer/start/neotest/lua/neotest/client/strategies
local lib = require("neotest.lib")
local nio = require("nio")
local FanoutAccum = require("neotest.types").FanoutAccum
local logger = require("neotest.logging")
local debug = logger.debug
local dap = require("dap")
local process = require("plugins.process")
local is_port_available = require("plugins.check_port").is_port_available

---@class integratedStrategyConfig
---@field height integer
---@field width integer

---@async
---@param spec neotest.RunSpec
---@return neotest.Process
return function(spec)
  debug("run spec dbx-dap")
  local env, cwd = spec.env, spec.cwd

  process.run({
    "ssh",
    "khang@khang-dbx",
    "-t",
    "echo 'build --define vscode_python_debugging=1' > ~/.bazelrc.user",
  }, { stdout = true, stderr = true }, "/Users/khang/src/server")

  local finish_future = nio.control.future()
  local result_code = nil
  local command = spec.command
  local data_accum = FanoutAccum(function(prev, new)
    if not prev then
      return new
    end
    return prev .. new
  end, nil)

  local attach_win, attach_buf, attach_chan
  local output_path = nio.fn.tempname()
  local open_err, output_fd = nio.uv.fs_open(output_path, "w", 438)
  assert(not open_err, open_err)

  data_accum:subscribe(function(data)
    local write_err, _ = nio.uv.fs_write(output_fd, data)
    assert(not write_err, write_err)
  end)

  local success, job = pcall(nio.fn.jobstart, command, {
    cwd = cwd,
    env = env,
    pty = true,
    height = spec.strategy.height,
    width = spec.strategy.width,
    on_stdout = function(_, data)
      -- default
      nio.run(function()
        data_accum:push(table.concat(data, "\n"))
      end)

      local id = spec.context.position_id
      debug("with data", data)
      debug("with id", id)
      for _, printed_id in ipairs(data) do
        debug("with printed_id", printed_id)
        if printed_id and #printed_id ~= 0 then
          -- trim
          printed_id = printed_id:gsub("^%s*(.-)%s*$", "%1")
          -- get before "<-"
          printed_id = printed_id:match("^(%S+)%s?")
          debug("with processed printed_id 2", printed_id)
          if printed_id and #printed_id ~= 0 then
            if string.sub(id, -string.len(printed_id)) == printed_id then
              debug("attach dap")

              local config = spec.context.debug_config
              if is_port_available(config.port) then
                debug(
                  "Local port " .. config.port .. " is still open. Need to forward port from devbox"
                )
                -- @TODO: handle ssh failure
                process.run({
                  "ssh",
                  "-L",
                  tostring(config.port),
                  ":$USER-dbx:",
                  tostring(config.port),
                  "-N",
                  "-f",
                  "$USER-dbx",
                }, { stdout = true, stderr = true }, "/Users/khang/src/server")
              end
              debug("enable debug flag on devbox")
              process.run({
                "ssh",
                "khang@khang-dbx",
                "-t",
                "echo 'build --define vscode_python_debugging=1' > ~/.bazelrc.user",
              }, { stdout = true, stderr = true }, "/Users/khang/src/server")

              debug("strategy config", spec.strategy)
              dap.run(vim.tbl_extend("keep", spec.strategy, { env = spec.env, cwd = spec.cwd }), {
                before = function(config)
                  return adapter_before and adapter_before() or config
                end,
                after = function()
                  if adapter_after then
                    adapter_after()
                  end
                end,
              })

              break
            end
          end
        else
        end
      end
    end,
    on_exit = function(_, code)
      result_code = code
      finish_future.set()
    end,
  })
  if not success then
    local write_err, _ = nio.uv.fs_write(output_fd, job)
    assert(not write_err, write_err)
    result_code = 1
    finish_future.set()
  end
  return {
    is_complete = function()
      return result_code ~= nil
    end,
    output = function()
      return output_path
    end,
    stop = function()
      nio.fn.jobstop(job)
    end,
    output_stream = function()
      local queue = nio.control.queue()
      data_accum:subscribe(function(d)
        queue.put(d)
      end)
      return function()
        return nio.first({ finish_future.wait, queue.get })
      end
    end,
    attach = function()
      -- nvim_create_buf returns 0 on error, but bufexists(0) tests for
      -- existance of an alternate file name, so coerce 0 to nil
      if attach_buf == 0 then
        attach_buf = nil
      end

      if nio.fn.bufexists(attach_buf) == 0 then
        attach_buf = nio.api.nvim_create_buf(false, true)
        attach_chan = lib.ui.open_term(attach_buf, {
          on_input = function(_, _, _, data)
            pcall(nio.api.nvim_chan_send, job, data)
          end,
        })
        data_accum:subscribe(function(data)
          pcall(nio.api.nvim_chan_send, attach_chan, data)
        end)
      end
      attach_win = lib.ui.float.open({
        height = spec.strategy.height,
        width = spec.strategy.width,
        buffer = attach_buf,
      })
      nio.api.nvim_buf_set_option(attach_buf, "filetype", "neotest-attach")
      nio.api.nvim_buf_set_option(attach_buf, "bufhidden", "wipe")
      attach_win:jump_to()
    end,
    result = function()
      if result_code == nil then
        finish_future:wait()
      end
      local close_err = nio.uv.fs_close(output_fd)
      assert(not close_err, close_err)
      pcall(nio.fn.chanclose, job)
      if attach_win then
        attach_win:listen("close", function()
          pcall(vim.api.nvim_buf_delete, attach_buf, { force = true })
          pcall(vim.fn.chanclose, attach_chan)
        end)
      end
      return result_code
    end,
  }
end

-- ---@param spec neotest.RunSpec
-- ---@return neotest.StrategyResult?
-- return function(spec)
--   debug('run spec dbx-dap')
--   if vim.tbl_isempty(spec.strategy) then
--     return
--   end
--   local dap = require("dap")
--
--   local handler_id = "neotest_" .. nio.fn.localtime()
--   local data_accum = FanoutAccum(function(prev, new)
--     if not prev then
--       return new
--     end
--     return prev .. new
--   end, nil)
--
--   local output_path = vim.fn.tempname()
--   local open_err, output_fd = nio.uv.fs_open(output_path, "w", 438)
--   assert(not open_err, open_err)
--
--   data_accum:subscribe(function(data)
--     local write_err, _ = nio.uv.fs_write(output_fd, data)
--     debug('output_fd', output_fd)
--     debug('with data', data)
--     assert(not write_err, write_err)
--   end)
--
--   local finish_future = nio.control.future()
--   local result_code
--
--   local adapter_before = spec.strategy.before
--   local adapter_after = spec.strategy.after
--   spec.strategy.before = nil
--   spec.strategy.after = nil
--
--   nio.scheduler()
--   dap.run(vim.tbl_extend("keep", spec.strategy, { env = spec.env, cwd = spec.cwd }), {
--     before = function(config)
--       dap.listeners.after.event_output[handler_id] = function(_, body)
--         if vim.tbl_contains({ "stdout", "stderr" }, body.category) then
--           nio.run(function()
--             data_accum:push(body.output)
--           end)
--         end
--       end
--       dap.listeners.after.event_exited[handler_id] = function(_, info)
--         result_code = info.exitCode
--         pcall(finish_future.set)
--       end
--
--       return adapter_before and adapter_before() or config
--     end,
--     after = function()
--       dap.listeners.after.event_output[handler_id] = nil
--       dap.listeners.after.event_exited[handler_id] = nil
--       if adapter_after then
--         adapter_after()
--       end
--     end,
--   })
--   return {
--     is_complete = function()
--       return result_code ~= nil
--     end,
--     output_stream = function()
--       local queue = nio.control.queue()
--       data_accum:subscribe(queue.put)
--       return function()
--         return nio.first({ finish_future.wait, queue.get })
--       end
--     end,
--     output = function()
--       return output_path
--     end,
--     attach = function()
--       dap.repl.open()
--     end,
--     result = function()
--       finish_future:wait()
--       return result_code
--     end,
--   }
-- end
