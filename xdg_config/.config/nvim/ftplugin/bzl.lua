vim.cmd [[
  set filetype=lua
]]

local function i(value)
    print(vim.inspect(value))
end

-- follow https://github.com/s1n7ax/youtube-neovim-treesitter-query/blob/main/README.md
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("foo", { clear = true }),
  pattern = "*.in",
  callback = function ()
    -- get current buffer number by "echo bufnr('%')"
    local bufid = 203
    local parser = vim.treesitter.get_parser(bufid, 'python')
    local tstree = parser:parse()[1]
    local root = tstree:root()
    local query = vim.treesitter.parse_query('python', [[
    (expression_statement
      (call
          function: (identifier) @func_name
            arguments: (argument_list
              (keyword_argument
                  name: (identifier) @name
                    value: (string) @value
                )
            )
      )
    )
    ]])

    local q = require"vim.treesitter.query"
    for id, match, metadata in query:iter_matches(root, bufid) do
      i(q.get_node_text(match[3], bufid))
    end
  end,
})

-- reload this file
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("foo2", { clear = true }),
  pattern = "bzl.lua",
  command = ":source %",
})

-- :help ui.select
-- local fname = vim.ui.select({ 'foo', 'bar' }, {
--   prompt = 'Select tabs or spaces:',
--   format_item = function(item)
--     return "I'd like to choose " .. item
--   end,
-- }, function(choice)
--     if choice == 'spaces' then
--       vim.o.expandtab = true
--     else
--       vim.o.expandtab = false
--     end
--   end)
