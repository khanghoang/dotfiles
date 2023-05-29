local dbx = require("plugins.dbx")

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

describe("dbx python adapter", function()
  it("should detect bazel stop and restart", function()
    local lines = {}

    -- Iterate over each line in the multiline string
    for line in need_restart_bazel_lines:gmatch("[^\r\n]+") do
      table.insert(lines, line)
    end

    local errorMessage = ""
    for _, line in ipairs(lines) do
      local success, errorMsg = pcall(dbx.parse_line, line)
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
