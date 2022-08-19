vim.cmd [[
  set filetype=python
]]

local function i(value)
    print(vim.inspect(value))
end

-- follow https://github.com/s1n7ax/youtube-neovim-treesitter-query/blob/main/README.md
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("foo", { clear = true }),
  pattern = "*.in",
  callback = function ()
    local bufid = 8
    local parser = vim.treesitter.get_parser(7, 'python')
    local tstree = parser:parse()[1]
    local root = tstree:root()
    local query = vim.treesitter.parse_query('python', [[
      (expression_statement
        (call
         function: (identifier) @annotation (#eq? @annotation "dbx_metaserver_jest_test")
         )
      )
    ]])

    local q = require"vim.treesitter.query"
    for id, match, metadata in query:iter_matches(root, 7) do
      i(q.get_node_text(match[2], 7))
    end
  end,
})

-- reload this file
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("foo2", { clear = true }),
  pattern = "bzl.lua",
  command = ":source %",
})
