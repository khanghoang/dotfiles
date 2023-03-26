local job = require("plenary.job")

local function json_encode(object)
  return vim.fn.json_encode(object)
end

local function json_decode(s)
  return vim.fn.json_decode(s)
end

local function run_job(cmd, args)
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

return {
  json_decode = json_decode,
  json_encode = json_encode,
  run_job = run_job,
}


