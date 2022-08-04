local function get_sourcegraph_type_url(url_data)
  local url = 'https://'
    .. url_data.host
    .. '/'
    .. url_data.repo
    .. '@'
    .. url_data.rev
    .. '/-/blob/'
    .. url_data.file
  if url_data.lstart then
    url = url .. '#L' .. url_data.lstart
    if url_data.lend then
      url = url .. '-L' .. url_data.lend
    end
  end
  return url
end

require('gitlinker').setup {
  callbacks = {
    ['git.sjc.dropbox.com'] = function(url_data)
      url_data.host = 'sourcegraph.pp.dropbox.com'
      url_data.repo = 'git.sjc.dropbox.com/server'
      url_data.rev = vim.fn.trim(
        vim.fn.system 'git merge-base HEAD origin/master'
      )
      return get_sourcegraph_type_url(url_data)
    end,
  },
}

vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true, noremap = false})
vim.api.nvim_set_keymap('v', '<leader>gb', ':lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {noremap = false})

