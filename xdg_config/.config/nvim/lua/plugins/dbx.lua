-- view log at 
-- lnav ~/.local/state/nvim/neotest.log

-- @TODO: handle dap debugger mode
-- @TODO: maintain status of devbox's debugging flag
-- @TODO: handle bazel reload failures, i.e. bazel-stop-all and start again
-- @TODO: properly handle skipped tests
-- @TODO: parse error
--
local async = require("neotest.async")
local lib = require("neotest.lib")
local Path = require("plenary.path")
local logger = require("neotest.logging")

---@param line string
---@return table<string, neotest.Result>
local function parse_line(line)
  -- Remove ANSI escape code color
  line = line:gsub("\27%[%d+m", "")
  -- remove tabs and multiple spaces
  line = line:gsub("%s+", " ")

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
  lib.files.match_root_pattern("pyproject.toml", "setup.cfg", "mypy.ini", "pytest.ini", "setup.py")

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function DbxPythonNeotestAdapter.filter_dir(name, rel_path, root)
  -- https://github.com/nvim-neotest/neotest-python/blob/master/lua/neotest-python/init.lua#LL79C3-L79C24
  return true
end

---@async
---@param file_path string
---@return boolean
function DbxPythonNeotestAdapter.is_test_file(file_path)
  -- consider all files are test file
  return true
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

  -- local results_path = async.fn.tempname()
  -- local stream_path = async.fn.tempname()
  -- lib.files.write(stream_path, "")
  -- lib.files.write(results_path, "")

  local root = DbxPythonNeotestAdapter.root(position.path)
  local relative = Path:new(position.path):make_relative(root)
  local script_args = vim.tbl_flatten({
    relative,
    "-I"
  })
  if position then
    table.insert(script_args, "--test_filter")
    table.insert(script_args, position.name)
  end

  -- table.insert(script_args, "> " .. stream_path)

  local command = vim.tbl_flatten({
    "mbzl",
    "tool",
    "//tools:run_test",
    script_args,
  })

  ---@type neotest.RunSpec
  return {
    command = command,
    context = {
      results_path = results_path,
      stop_stream = stop_stream,
      stream_path = stream_path,
    },
    stream = function(output_stream)
      return function()
        local lines = output_stream()
        local results = {}
        for _, line in ipairs(lines) do
          for testLongName, res in pairs(parse_line(line)) do
            results[testLongName] = res
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
    for testLongName, res in pairs(parse_line(line)) do
      results[testLongName] = res
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
