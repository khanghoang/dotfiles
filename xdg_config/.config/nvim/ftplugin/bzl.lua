local function i(value)
    print(vim.inspect(value))
end

-- follow https://github.com/s1n7ax/youtube-neovim-treesitter-query/blob/main/README.md
vim.api.nvim_create_autocmd("BufWritePost", {
 group = vim.api.nvim_create_augroup("foo", { clear = true }),
  pattern = "*.java",
  callback = function ()
    local parser = vim.treesitter.get_parser(0, 'java')
    local tstree = parser:parse()[1]
    local root = tstree:root()
    local query = vim.treesitter.parse_query('java', [[
      (method_declaration
    (modifiers
        (marker_annotation 
            name: (identifier) @annotation (#eq? @annotation "Test")))
            name: (identifier) @method (#offset! @method))
    ]])

    local q = require"vim.treesitter.query"
    for id, match, metadata in query:iter_matches(root, 0) do
      i(q.get_node_text(match[2], 0))
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
 group = vim.api.nvim_create_augroup("foo3", { clear = true }),
  pattern = "*.in",
  callback = function ()
    local parser = vim.treesitter.get_parser(0, 'python')
    local tstree = parser:parse()[1]
    local root = tstree:root()
    local query = vim.treesitter.parse_query('python', [[
      (keyword_argument
        value: (string) @value (#eq? @value "\"foo\""))
    ]])

    local q = require"vim.treesitter.query"
    for id, match, metadata in query:iter_matches(root, 0) do
      i(q.get_node_text(match[1], 0))
    end
  end,
})

-- reload this file
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("foo2", { clear = true }),
  pattern = "bzl.lua",
  command = ":source %",
})
