local M = {}
local is_port_available = require("libs.check_port").is_port_available

-- README: Cannot run check health asynchronously because it
-- doesn't know if the `check()` function is async or sync
-- one

local start = vim.health.start
local ok = vim.health.report_ok
local info = vim.health.report_info
local error = vim.health.report_error
local warn = vim.health.report_warn

local REMOTE = '$USER-dbx'
local ATLAS_DEBUG_PORT = 56237
local ATLAS_TEST_DEBUG_PORT = 56234

function execute_command(command)
    local file = io.popen(command, 'r')
    if file then
      local output = file:read('*a')
      file:close()
      return output
    end
end

local function forward_port(port, remote)
  os.execute(
    "ssh -L "
    .. tostring(port)
    .. ":".. remote ..":"
    .. tostring(port)
    .. " -N -f " .. remote
  )
end

local function check_port(port, should_forward_port)
  should_forward_port = should_forward_port or true
  if not is_port_available(port) then
    ok(port .. ' is ready!!')
    return true
  end

  warn(port .. ' is not forwarded yet!!!')
  if should_forward_port then
    info('Attempt to forward ' .. port)
    forward_port(port, REMOTE)
    check_port(port, false)
  end
  return false
end

local function check_bazel_flag(should_fix)
  should_fix = should_fix or true
  local content = execute_command("ssh ".."$USER".."@"..REMOTE.. " 'cat ~/.bazelrc.user'")
  if content == "build --define vscode_python_debugging=1\n" then
    ok("Bazel debugging flag set up correctly")
  else
    error("Missing bazel debugging flag")
    if should_fix then
      info('Attempt to set up bazel debugging flag')
      os.execute("ssh ".."$USER".."@"..REMOTE.. " -t \"echo \'build --define vscode_python_debugging=1\' > ~/.bazelrc.user\"")
      check_bazel_flag(false)
    else
      warn("You may want to add 'build --define vscode_python_debugging=1' into your bzl config file `~/.bazelrc.user` on devbox")
    end
  end
end

local function check_debugpy_config(should_fix)
  local file = "~/bzl/itest/root/.local_dev_options.json"
  should_fix = should_fix or true
  local content = execute_command("ssh ".."$USER".."@"..REMOTE.. " 'cat "..file.."'")
  info(content)
  local config = vim.json.decode(content)
  if config.DEBUGPY.ATLAS_ATLAS.PORT == ATLAS_DEBUG_PORT then
    ok('Atlas debug port is ' .. ATLAS_DEBUG_PORT)
    info('Atlas test debug port inferred ' .. ATLAS_DEBUG_PORT)
  else
    error('Cannot find Atlas debug port in '..file)
  end
end

local function _check()
  start("Check remote bazel debug config")

  -- check ports forwarded
  check_port(ATLAS_DEBUG_PORT)
  check_port(ATLAS_TEST_DEBUG_PORT)

  -- check bzl debugging flag
  check_bazel_flag()
  check_debugpy_config()

  info("Please always use `mbzl run <target>` instead of `mbzl start <target> since `start` won't keep the connection")
end

M.check = _check
return M
