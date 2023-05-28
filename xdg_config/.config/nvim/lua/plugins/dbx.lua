-- view log at 
-- lnav ~/.local/state/nvim/neotest.log

-- @TODO: handle dap debugger mode
-- @TODO: maintain status of devbox's debugging flag
-- @TODO: properly handle skipped tests
-- @TODO: parse error
--
local async = require("neotest.async")
local lib = require("neotest.lib")
local Path = require("plenary.path")
local logger = require("neotest.logging")
local neotest = require("neotest")
local process = require'plugins.process'
local is_port_available = require("plugins.check_port").is_port_available

local dap_args
local debug = logger.debug

local function get_strategy_config(strategy, python, program, args)
  local config = {
    ["neotest-dbx-dap"] = function()
      return vim.tbl_extend("keep", {
        type = "python",
        request = "attach",
        name = "Attach remote",
        cwd = async.fn.getcwd(),
        connect = function()
          local config_index = 2
          local configs = {
            { host = "localhost", port = 56237 },
            { host = "localhost", port = 56234 },
          }

          local config = configs[config_index]
          -- if is_port_available(config.port) then
          --   debug("Local port " .. config.port .. " is still open. Need to forward port from devbox")
          --   -- @TODO: handle ssh failure
          --   os.execute(
          --     "ssh -L "
          --     .. tostring(config.port)
          --     .. ":$USER-dbx:"
          --     .. tostring(config.port)
          --     .. " -N -f $USER-dbx"
          --   )
          -- end

          return config
        end,
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(),
            -- Same as WORKDIR on your devbox
            remoteRoot = "/home/khang/src/server-mirror",
          },
        },
      }, dap_args or {})
    end,
  }
  if config[strategy] then
    return config[strategy]()
  end
end

local function stop_current_bazel_target()
  -- this function runs synchronously
  process.run({ "mbzl", "itest-stop-all", "--force" }, { stdout = true, stderr = true }, "/Users/khang/src/server")
end

local function handle_parse_line_error(errorMsg)
  -- @TODO: need to pass cwd?
  -- if errorMsg == "NEED_BZL_STOP_AND_RESTART" then
  -- @TODO: need to pass cwd?
  logger.debug("bzl stop all")
  stop_current_bazel_target()
end

---@param line string
---@return table<string, neotest.Result>
local function parse_line(line)
  -- Remove ANSI escape code color
  line = line:gsub("\27%[%d+m", "")
  -- remove tabs and multiple spaces
  line = line:gsub("%s+", " ")

  local should_restart_bazel = string.match(line, "Try running the following to remove all containers and start a new container for")
  if should_restart_bazel then
    logger.debug("restart bazel request sent")
    error("NEED_BZL_STOP_AND_RESTART")
  end

  logger.debug('input line', line)
  -- Extract the test case name
  local passTestName = line:match("([^%s]+%.[^%s]+::.+)%s*PASSED")

  local result = {}
  if passTestName then
    -- trim
    passTestName = passTestName:gsub("^%s*(.-)%s*$", "%1")
    -- get before "<-"
    passTestName = passTestName:match("^(%S+)%s?")
    result = {
      [passTestName] = {
        status = "passed"
      }
    }
  end

  local failedTestName = line:match("([^%s]+%.[^%s]+::.+)%s*FAILED")
  if failedTestName then
    -- trim
    failedTestName = failedTestName:gsub("^%s*(.-)%s*$", "%1")
    -- get before "<-"
    failedTestName = failedTestName:match("^(%S+)%s?")
    result = {
      [failedTestName] = {
        status = "failed"
      }
    }
  end

  logger.debug("parsed line", vim.inspect(result))
  return result
end


---@type neotest.Adapter
local DbxPythonNeotestAdapter = { name = "dbx-python" }

DbxPythonNeotestAdapter.root =
  lib.files.match_root_pattern("pyproject.toml", "setup.cfg", "mypy.ini", "pytest.ini", "setup.py", ".git")

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
-- function DbxPythonNeotestAdapter.filter_dir(name, rel_path, root)
--   -- https://github.com/nvim-neotest/neotest-python/blob/master/lua/neotest-python/init.lua#LL79C3-L79C24
--   return true
-- end

---@async
---@param file_path string
---@return boolean
function DbxPythonNeotestAdapter.is_test_file(file_path)
  -- consider all files are test file
  return file_path ~= "" and not vim.endswith(file_path, lib.files.sep)
end

---Given a file path, parse all the tests within it.
---@async
---@param path string Absolute file path
---@return neotest.Tree | nil
function DbxPythonNeotestAdapter.discover_positions(path)
  local query = [[
    ;; Match undecorated functions
    ((function_definition
      name: (identifier) @test.name)
      (#match? @test.name "^test"))
      @test.definition
    ;; Match decorated function, including decorators in definition
    (decorated_definition
      ((function_definition
        name: (identifier) @test.name)
        (#match? @test.name "^test")))
        @test.definition

    ;; Match decorated classes, including decorators in definition
    (decorated_definition
      (class_definition
       name: (identifier) @namespace.name))
      @namespace.definition
    ;; Match undecorated classes: namespaces nest so #not-has-parent is used
    ;; to ensure each namespace is annotated only once
    (
     (class_definition
      name: (identifier) @namespace.name)
      @namespace.definition
     (#not-has-parent? @namespace.definition decorated_definition)
    )
  ]]
  return lib.treesitter.parse_positions(path, query, {
    -- https://github.com/nvim-neotest/neotest-python/blob/master/lua/neotest-python/init.lua#L116
    require_namespaces = true
  })
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function DbxPythonNeotestAdapter.build_spec(args)
  local position = args.tree:data()

  local results_path = async.fn.tempname()
  lib.files.write(results_path, "")
  -- local stream_path = async.fn.tempname()
  -- lib.files.write(stream_path, "")

  local root = DbxPythonNeotestAdapter.root(position.path)
  local relative = Path:new(position.path):make_relative(root)
  local script_args = vim.tbl_flatten({
    relative,
  })
  if position then
    table.insert(script_args, "--test_filter")
    table.insert(script_args, position.name)
  end

  -- this flag needs to be placed before --vscode-wait
  table.insert(script_args, "-I")

  local config
  if args.strategy == "neotest-dbx-dap" then
    table.insert(script_args, "--test_arg=--vscode-wait")

    local config_index = 2
    local configs = {
      { host = "localhost", port = 56237 },
      { host = "localhost", port = 56234 },
    }

    config = configs[config_index]
    if is_port_available(config.port) then
      debug("Local port " .. config.port .. " is still open. Need to forward port from devbox")
      -- @TODO: handle ssh failure
      process.run({ "ssh", "-L", tostring(config.port), ":$USER-dbx:", tostring(config.port), '-N', "-f", "$USER-dbx" }, { stdout = true, stderr = true }, "/Users/khang/src/server")
    end
    debug("enable debug flag on devbox")
    process.run({ "ssh", "khang@khang-dbx", "-t", "echo \'build --define vscode_python_debugging=1\' > ~/.bazelrc.user" }, { stdout = true, stderr = true }, "/Users/khang/src/server")
  else
    debug("disable debug flag on devbox")
    process.run({ "ssh", "khang@khang-dbx", "-t", "echo > ~/.bazelrc.user" }, { stdout = true, stderr = true }, "/Users/khang/src/server")
  end

  local command = vim.tbl_flatten({
    "mbzl",
    "tool",
    "//tools:run_test",
    script_args,
  })

  debug('final command', command)

  -- pass output_stream here
  local strategy_config = get_strategy_config(args.strategy)

  ---@type neotest.RunSpec
  return {
    command = command,
    context = {
      results_path = results_path,
      position_id = position.id,
      debug_config = config,
    },
    stream = function(output_stream)
      return function()
        local lines = output_stream()
        local results = {}
        for _, line in ipairs(lines) do
          local success, errorMsg = pcall(parse_line, line);
          if not success then
            logger.debug('error message', errorMsg)
            -- don't need to handle error here since it alread
            -- properly handled in the final result fn
            return {}
          end

          if success then
            local data = parse_line(line)
            for testLongName, res in pairs(data) do
              results[testLongName] = res
            end
          end
        end

        local ret = {}

        for _, node in args.tree:iter_nodes() do
          local value = node:data()
          local id = value.id

          local found = false
          for testLongName, res in pairs(results) do
            if string.sub(id, -string.len(testLongName)) == testLongName then
              ret[id] = res
              found = true
            end
          end
        
          if not found then
            -- @TODO optimize this
            ret[id] = nil
          end

        end
        logger.debug("final_results", ret)
        return ret
      end
    end,
    strategy = strategy_config
  }
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function DbxPythonNeotestAdapter.results(spec, result, tree)
  local _, lines = pcall(lib.files.read_lines, result.output)
  local results = {}
  for _, line in ipairs(lines) do
    logger.debug('result_line', line)
    local success, errorMsg = pcall(parse_line, line);

    if not success then
      logger.debug('error message', errorMsg)
      handle_parse_line_error(errorMsg)
      logger.debug("neotest run last")
      neotest.run.run_last()

      local ret = {}
      -- indicate temporary failure due to bzl stop as
      -- skipped
      for _, node in tree:iter_nodes() do
        local value = node:data()
        local id = value.id
        ret[id] = {
          status = "running"
        }
      end
      return ret

    end

    if success then
      local data = parse_line(line)
      for testLongName, res in pairs(data) do
        results[testLongName] = res
      end
    end

  end

  local ret = {}

  for _, node in tree:iter_nodes() do
    local value = node:data()
    local id = value.id

    -- @TODO optimize this
    ret[id] = {
      status = "skipped"
    }
    for testLongName, res in pairs(results) do
      if string.sub(id, -string.len(testLongName)) == testLongName then
        ret[id] = res
      end
    end
  end

  logger.debug("final_results", ret)
  return ret
  -- return results
end

return DbxPythonNeotestAdapter
