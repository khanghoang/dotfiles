# Stream json pytest report to support displying error

## Custom pytest report

```python
import pytest

# Define a custom pytest plugin
@pytest.hookimpl(tryfirst=True)
def pytest_terminal_summary(terminalreporter):
    # Customize the test report summary
    passed = len(terminalreporter.stats.get('passed', []))
    failed = len(terminalreporter.stats.get('failed', []))
    skipped = len(terminalreporter.stats.get('skipped', []))

    # Add additional information to the summary
    custom_summary = f"Custom Summary: {passed} passed, {failed} failed, {skipped} skipped"

    # Append the custom summary to the existing report
    terminalreporter.summary.append(custom_summary)

# Test function
def test_example():
    assert 2 + 2 == 4

def test_another_example():
    assert 2 * 2 == 5

def test_skip_example():
    pytest.skip("Skipping this test")

# Run pytest with the custom plugin
# pytest --custom-plugin example.py

```

## NeoTest Python (w/ stream)

https://github.com/nvim-neotest/neotest-python/blob/master/neotest_python/pytest.py

## Notes:

- [] Will not write output to file but rater just put it in stdout
- [Definition of dbx_py_pytest_test](https://sourcegraph.pp.dropbox.com/server/-/blob/build_tools/py/cfg.bzl?L9:75)
- [Bazel pytest flags setup](https://sourcegraph.pp.dropbox.com/server/-/blob/build_tools/copybara/files/build_tools/py/cfg.bzl?L16)
    - [Pytest code coverage plugin](https://sourcegraph.pp.dropbox.com/server/-/blob/build_tools/py/pytest_plugins/codecoverage.py)
- [BZL_DONT_USE_SQPKG Flag](https://sourcegraph.pp.dropbox.com/server/-/blob/build_tools/bzl_lib/itest/itest.py?L4)

## dbx build tool

https://github.com/dropbox/dbx_build_tools/tree/master
