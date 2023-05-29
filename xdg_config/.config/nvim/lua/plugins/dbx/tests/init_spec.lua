local assert = require("luassert")
local async = require("nio.tests")
local plugin = require("plugins.dbx")

local function debug(v)
  io.stdout:write(tostring(v))
  io.stdout:write("\t")
end

-- Function to assert if two tables are equal
local function assertTablesEqual(expected, actual)
  local function deepCompare(tbl1, tbl2)
    if type(tbl1) ~= "table" or type(tbl2) ~= "table" then
      return tbl1 == tbl2
    end

    for k, v in pairs(tbl1) do
      if not deepCompare(tbl2[k], v) then
        return false
      end
    end

    for k, v in pairs(tbl2) do
      if not deepCompare(tbl1[k], v) then
        return false
      end
    end

    return true
  end

  assert(deepCompare(expected, actual), "Tables are not equal")
end

local function parse_lines(str)
  local lines = {}

  -- Iterate over each line in the multiline string
  for line in str:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  return lines
end

describe("dbx python adapter", function()

  describe("_parse_line", function()
    it("should detect bazel stop and restart", function()
      local need_restart_bazel_lines = [[
I0528 18:49:13.658 28417 gitr_syncd.py:971] full-sync: 1.186s git-sync: 0.0s file-sync: 0.0s for 0 files


bzl itest-reload --test_arg=-k=test_buy_redirect_to_order_confirmation --test_arg=--vscode-wait //metaserver/controllers/tests/moneytree_team_payments:moneytree_team_payments_tests_3



[32mINFO: [0mInvocation ID: 74108a39-0890-495a-b838-06b547890d89

[32mLoading:[0m


[1A[K[32mLoading:[0m


[1A[K[32mLoading:[0m 0 packages loaded


[1A[K[32mAnalyzing:[0m 3 targets (0 packages loaded, 0 targets configured)


[1A[K[32mAnalyzing:[0m 3 targets (1 packages loaded, 7099 targets configured)


[1A[K[32mAnalyzing:[0m 3 targets (1 packages loaded, 26291 targets configured)


[1A[K[32mINFO: [0mAnalyzed 3 targets (1 packages loaded, 26475 targets configured).

[0m checking cached actions


[1A[K[32mINFO: [0mFound 3 targets...

[0m checking cached actions


[1A[K[0m checking cached actions


[1A[K[32m[0 / 3][0m [Prepa] BazelWorkspaceStatusAction stable-status.txt


[1A[K[32m[1,977 / 3,091][0m checking cached actions


[1A[K[32m[19,599 / 20,416][0m [Prepa] action 'FileWrite build-info-volatile.h'


[1A[K[32m[21,102 / 24,589][0m checking cached actions


[1A[K[32m[33,462 / 33,502][0m [Prepa] //metaserver/controllers/tests/moneytree_team_payments:moneytree_team_payments_tests_3


[1A[K[32m[33,470 / 33,502][0m 22 actions, 14 running

    SvcVersionFile atlas/fs_mount_transition/atlas-testonly_test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/fs_mount_transition/atlas-test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/cx_technology/atlas-test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/ux_analytics/atlas-test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/data_modules/atlas-testonly_test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/impa/atlas-live_test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/cx_technology/atlas-multithreaded_live_test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local

    SvcVersionFile atlas/cx_technology/atlas-live_test_service-service-extensions/py-binary/atlas/atlas_py_binary.version; 0s local ...


[1A[K
[1A[K
[1A[K
[1A[K
[1A[K
[1A[K
[1A[K
[1A[K
[1A[K[32m[33,502 / 33,502][0m checking cached actions


[1A[K[32mINFO: [0mElapsed time: 9.350s, Critical Path: 0.84s

[32m[33,502 / 33,502][0m checking cached actions


[1A[K[32mINFO: [0m42 processes: 1 disk cache hit, 2 internal, 39 local.

[32m[33,502 / 33,502][0m checking cached actions


[1A[K[32mINFO:[0m Build completed successfully, 42 total actions

[0mA `bzl itest` container must already be running for target //metaserver/controllers/tests/moneytree_team_payments:moneytree_team_payments_tests_3. Additionally, there are existing `bzl itest` containers.

Try running the following to remove all containers and start a new container for //metaserver/controllers/tests/moneytree_team_payments:moneytree_team_payments_tests_3:



bzl itest-stop-all && bzl itest-run //metaserver/controllers/tests/moneytree_team_payments:moneytree_team_payments_tests_3



ERROR: //tools:run_test did not exit successfully.

If you suspect that there's a problem with the tool, try contacting the team that owns it: ci-automation
]]

      local lines = parse_lines(need_restart_bazel_lines)

      local errorMessage = ""
      for _, line in ipairs(lines) do
        local success, errorMsg = pcall(plugin._parse_line, line)
        if not success then
          ---@diagnostic disable-next-line: cast-local-type
          errorMessage = errorMsg
        end
      end

      local expected = "NEED_BZL_STOP_AND_RESTART"
      -- this has both line number and error massge
      ---@diagnostic disable-next-line: param-type-mismatch
      local actual = string.sub(errorMessage, -string.len(expected))
      assert.equal(actual, expected)
    end)
  end)

  async.it("parses single result", function()
    local output = [[
I0528 21:33:14.212 9569 gitr_syncd.py:971] full-sync: 1.197s git-sync: 0.0s file-sync: 0.0s for 0 files


bzl itest-reload --test_arg=-k=test_foo_2 //atlas/decorator_tests/tests_foo:foo_tests



[32mINFO: [0mInvocation ID: 09a7242d-54d0-4b82-8832-72c589dec044

[32mLoading:[0m


[1A[K[32mLoading:[0m


[1A[K[32mLoading:[0m 0 packages loaded


[1A[K[32mAnalyzing:[0m 3 targets (0 packages loaded, 0 targets configured)


[1A[K[32mINFO: [0mAnalyzed 3 targets (1 packages loaded, 114 targets configured).

[0m checking cached actions


[1A[K[32mINFO: [0mFound 3 targets...

[0m checking cached actions


[1A[K[32m[1 / 13][0m [Prepa] BazelWorkspaceStatusAction stable-status.txt


[1A[K[32mINFO: [0mElapsed time: 1.077s, Critical Path: 0.06s

[32m[2,904 / 2,904][0m checking cached actions


[1A[K[32mINFO: [0m1 process: 1 internal.

[32m[2,904 / 2,904][0m checking cached actions


[1A[K[32mINFO:[0m Build completed successfully, 1 total action

[0m[1m================================================================ test session starts =================================================================[0m

platform linux -- Python 3.9.14, pytest-7.1.1, pluggy-0.13.1 -- /mnt/cache/bazel/output/339cddb5af73fe0d62ee16fe5bc4d6ca/execroot/__main__/bazel-out/k8-fastbuild/bin/atlas/decorator_tests/tests_foo/foo_tests.runfiles/__main__/../drtev5_python_39/bin/python

rootdir: /mnt/cache/bazel/output/339cddb5af73fe0d62ee16fe5bc4d6ca/execroot/__main__/bazel-out/k8-fastbuild/bin/atlas/decorator_tests/tests_foo/foo_tests.runfiles/__main__, configfile: pytest.ini

plugins: asyncio-0.18.0

asyncio: mode=auto

[1mcollecting ... [0m[1m
collected 2 items / 1 deselected / 1 selected                                                                                                        [0m



xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo_2 [32mPASSED[0m[32m                                                                          [100%][0m



----------------------------------------------------------- generated xml file: /dev/null ------------------------------------------------------------

[32m========================================================== [32m[1m1 passed[0m, [33m1 deselected[0m[32m in 0.02s[0m[32m ===========================================================[0m


    ]]

    local tests_folder = vim.loop.cwd() .. "/xdg_config/.config/nvim/lua/plugins/dbx/tests"
    local test_file = tests_folder .. "/foo_tests.py"
    local tree = plugin.discover_positions(test_file)
    local lines = parse_lines(output)
    ---@diagnostic disable-next-line: param-type-mismatch
    local processed_results = plugin.prepare_results(tree, lines)
    local expected = {
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py"] = {
        status = "skipped",
      },
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test"] = {
        status = "skipped",
      },
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo"] = {
        status = "skipped",
      },
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo_2"] = {
        status = "passed",
      },
    }
    -- debug(vim.inspect(processed_results))
    assertTablesEqual(expected, processed_results)
  end)

  async.it("parses mutliple results", function()
    local output = [[
I0528 22:39:29.430 25688 gitr_syncd.py:971] full-sync: 2.759s git-sync: 0.0s file-sync: 0.0s for 0 files


bzl itest-start //atlas/decorator_tests/tests_foo:foo_tests



[32mINFO: [0mInvocation ID: 784aa22d-645a-459d-840c-7ee9a1ded67d

[32mLoading:[0m 


[1A[K[32mLoading:[0m 


[1A[K[32mLoading:[0m 0 packages loaded


[1A[K[32mAnalyzing:[0m 3 targets (0 packages loaded, 0 targets configured)


[1A[K[32mINFO: [0mAnalyzed 3 targets (1 packages loaded, 114 targets configured).

[0m checking cached actions


[1A[K[32mINFO: [0mFound 3 targets...

[0m checking cached actions


[1A[K[32m[1 / 10][0m [Prepa] BazelWorkspaceStatusAction stable-status.txt


[1A[K[32mINFO: [0mElapsed time: 1.110s, Critical Path: 0.06s

[32m[2,904 / 2,904][0m checking cached actions


[1A[K[32mINFO: [0m1 process: 1 internal.

[32m[2,904 / 2,904][0m checking cached actions


[1A[K[32mINFO:[0m Build completed successfully, 1 total action

[0mmissing mount point: b'/run/dropbox/sock-drawer/'

[1m================================================================ test session starts =================================================================[0m

platform linux -- Python 3.9.14, pytest-7.1.1, pluggy-0.13.1 -- /mnt/cache/bazel/output/339cddb5af73fe0d62ee16fe5bc4d6ca/execroot/__main__/bazel-out/k8-fastbuild/bin/atlas/decorator_tests/tests_foo/foo_tests.runfiles/__main__/../drtev5_python_39/bin/python

rootdir: /mnt/cache/bazel/output/339cddb5af73fe0d62ee16fe5bc4d6ca/execroot/__main__/bazel-out/k8-fastbuild/bin/atlas/decorator_tests/tests_foo/foo_tests.runfiles/__main__, configfile: pytest.ini

plugins: asyncio-0.18.0

asyncio: mode=auto

[1mcollecting ... [0m[1m
collected 2 items                                                                                                                                    [0m



xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo [32mPASSED[0m[32m                                                                            [ 50%][0m

xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo_2 [32mPASSED[0m[32m                                                                          [100%][0m



----------------------------------------------------------- generated xml file: /dev/null ------------------------------------------------------------


[32m================================================================= [32m[1m2 passed[0m[32m in 0.02s[0m[32m ==================================================================[0m

Service controller logs are at /bzl/itest/per-container/test_tmpdir/logs/svcctl.log

Individual service logs are at /bzl/itest/per-container/test_tmpdir/logs/service_logs/

Logs are stored on the host at /home/khang/bzl/itest/per-container/bzl-itest_atlas-decorator_tests-tests_foo-foo_tests/test_tmpdir/logs/


    ]]

    local tests_folder = vim.loop.cwd() .. "/xdg_config/.config/nvim/lua/plugins/dbx/tests"
    local test_file = tests_folder .. "/foo_tests.py"
    local tree = plugin.discover_positions(test_file)
    local lines = parse_lines(output)
    ---@diagnostic disable-next-line: param-type-mismatch
    local processed_results = plugin.prepare_results(tree, lines)
    local expected = {
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py"] = {
        status = "skipped",
      },
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test"] = {
        status = "skipped",
      },
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo"] = {
        status = "passed",
      },
      ["/Users/khang/dotfiles/xdg_config/.config/nvim/lua/plugins/dbx/tests/foo_tests.py::Test::test_foo_2"] = {
        status = "passed",
      },
    }
    debug(vim.inspect(processed_results))
    assertTablesEqual(expected, processed_results)
  end)
end)
