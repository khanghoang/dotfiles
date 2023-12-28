local M = {}

-- README: Cannot run check health asynchronously because it
-- doesn't know if the `check()` function is async or sync
-- one

local start = vim.health.start
local ok = vim.health.report_ok
local error = vim.health.report_error
local warn = vim.health.report_warn

local function check_setup()
  return true
end

local function _check()
  start("Check ")
  -- make sure setup function parameters are ok
  if check_setup() then
    ok("Setup is correct")
  else
    error("Setup is incorrect")
  end
end

M.check = _check
return M
