local async = require("neotest.async")
local lib = require("neotest.lib")
local base = require("neotest-python.base")
local Path = require("plenary.path")
local logger = require("neotest.logging")

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
  lib.files.write(results_path, "")

  local root = DbxPythonNeotestAdapter.root(position.path)
  local stream_data, stop_stream = lib.files.stream_lines(stream_path)

  -- local relative_path = "metaserver/atf_lambdas/devbox_lambdas/tests/devbox_lambdas_test.py"
  -- mbzl tool //tools:run_test metaserver/lib/growth/rightsizing/tests/rightsizing_tests.py --test_filter=test_rightsizing_linked_team_user -I
  logger.debug("results_path", results_path)
  logger.debug("kyle")

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

  -- local command = vim.tbl_flatten({
  --   "mbzl",
  --   "tool",
  --   "//tools:run_test",
  --   script_args,
  -- })

  local command = { "echo ''" }

  ---@type neotest.RunSpec
  return {
    command = command,
    context = {
      results_path = results_path,
      stop_stream = stop_stream,
      stream_path = stream_path,
    },
    stream = function()
      return function()
        local lines = stream_data()
        local results = {}
        for _, line in ipairs(lines) do
          local result = vim.json.decode(line, { luanil = { object = true } })
          results[result.id] = result.result
        end
        return results
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
  spec.context.stop_stream()
  local success, lines = pcall(lib.files.read, spec.context.output)
  -- logger.debug('results data', result.output)
  -- logger.debug('results data 2', data)
  local results = {}
  logger.debug('foobaz')
  local position = tree:data()
  for _, node in tree:iter_nodes() do
    local value = node:data()
    results[value.id] = {
      status = "failed",
      output = result.output,
    }
  end
  logger.debug("final_results", results)
  return results
  -- @TODO: parse the file
  -- -- TODO: Find out if this JSON option is supported in future
  -- local results = vim.json.decode(data, { luanil = { object = true } })
  -- for _, pos_result in pairs(results) do
  --   result.output_path = pos_result.output_path
  -- end
  -- return results
end

return DbxPythonNeotestAdapter
