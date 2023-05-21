local async = require("neotest.async")
local lib = require("neotest.lib")
local base = require("neotest-python.base")
local Path = require("plenary.path")
local logger = require("neotest.logging")
local nio = require("nio")

local is_test_file = base.is_test_file

-- view log at 
-- lnav ~/.local/state/nvim/neotest.log

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
  -- return is_test_file(file_path)
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
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
  local stream_path = async.fn.tempname()
  lib.files.write(stream_path, "")
  -- lib.files.write(results_path, "")

  local root = DbxPythonNeotestAdapter.root(position.path)
  -- local relative_path = "metaserver/atf_lambdas/devbox_lambdas/tests/devbox_lambdas_test.py"
  -- mbzl tool //tools:run_test metaserver/lib/growth/rightsizing/tests/rightsizing_tests.py --test_filter=test_rightsizing_linked_team_user -I

  local relative = Path:new(position.path):make_relative(root)
  -- The path for the position is not a directory, ensure the directory variable refers to one
  -- if vim.fn.isdirectory(position.path) ~= 1 then
  --   dir = vim.fn.fnamemodify(position.path, ":h")
  -- end
  local script_args = vim.tbl_flatten({
    relative,
    "-I"
  })
  if position then
    table.insert(script_args, "--test_filter")
    -- position.id = /Users/khang/src/server/atlas/decorator_tests/tests/uid_aware_tests.py::UidAwareTests::test_allowed_roles_paired_user_both_logged_in
    -- position.name = est_allowed_roles_paired_user_both_logged_in

    table.insert(script_args, position.name)
  end

  local command = vim.tbl_flatten({
    "mbzl",
    "tool",
    "//tools:run_test",
    script_args,
  })
  -- local command = {"ls"}

  ---@type neotest.RunSpec
  return {
    command = command,
    context = {
      results_path = results_path,
      -- stop_stream = stop_stream,
      stream_path = stream_path,
    },
    -- stream = function()
    --   return function()
    --     local lines = stream_data()
    --     logger.debug("steamed_lines", lines)
    --     local results = {}
    --     for _, line in ipairs(lines) do
    --       local result = vim.json.decode(line, { luanil = { object = true } })
    --       results[result.id] = result.result
    --     end
    --     return results
    --   end
    -- end,
  }
end

---@param line string
---@return table<string, neotest.Result>
local function parse_line(line)
  -- line = "atlas/decorator_tests/tests/uid_aware_tests.py::UidAwareTests::test_uid_aware_migration_role_session_optional_paired <- metaserver/tests/community_owned_expensive_and_slow_utils/mock_session.py PASSED      [ 86%]"
  -- Remove ANSI escape code color
  local line = line:gsub("\27%[%d+m", "")
  -- remove tabs and multiple spaces
  local line = line:gsub("%s+", " ")

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

  -- Extract the test result
  -- atlas/decorator_tests/tests/uid_aware_tests.py::UidAwareTests::test_uid_aware_migration_role <- metaserver/tests/community_owned_expensive_and_slow_utils/mock_session.py PASSED
  --
  -- atlas/decorator_tests/tests/uid_aware_tests.py::UidAwareTests::test_uid_aware_migration_role PASSED
  --
  -- atlas/decorator_tests/tests/uid_aware_tests.py::UidAwareTests::test_allowed_roles_paired_user_both_logged_in <- metaserver/tests/community_owned_expensive_and_slow_utils/mock_session.py FAILED
  --
  -- atlas/decorator_tests/tests/uid_aware_tests.py::UidAwareTests::test_allowed_roles_paired_user_both_logged_inend FAILED
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function DbxPythonNeotestAdapter.results(spec, result, tree)
  -- spec.context.stop_stream()
  local success, lines = pcall(lib.files.read_lines, result.output)
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

    logger.debug('node id', id)

    -- @TODO optimize this
    ret[id] = {
      status = "skipped"
    }
    for testLongName, res in pairs(results) do
      logger.debug('test long name', testLongName)
      if string.sub(id, -string.len(testLongName)) == testLongName then
        ret[id] = res
      end
    end

    -- results[value.id] = {
    --   status = "failed",
    --   output = result.output,
    -- }
  end
  logger.debug("final_results", ret)
  return ret
  -- @TODO: parse the file
  -- -- TODO: Find out if this JSON option is supported in future
  -- local results = vim.json.decode(data, { luanil = { object = true } })
  -- for _, pos_result in pairs(results) do
  --   result.output_path = pos_result.output_path
  -- end
  -- return results
end

return DbxPythonNeotestAdapter
