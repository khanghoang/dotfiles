local dap = require('dap')
local dapui = require('dapui')

local api = vim.api
local installation_path = vim.fn.stdpath('data') .. '/mason/bin'

-- May need to symlink manually, for example
-- ln -sf ~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3 ~/.local/share/nvim/mason/bin/
-- Though for debugpy, it needs the full path of the even python3, and
-- I still don't know why
dap.adapters.python = function(cb, config)
  -- example to debug in DOCKER
  -- https://github.com/awwalker/nvim-dap/pull/1/files
  if config.request == 'attach' then
    local port = (config.connect or config).port
    cb({
      type = 'server';
      port = assert(port, '`connect.port` is required for a python `attach` configuration');
      host = (config.connect or config).host or '127.0.0.1';
      cwd = config.cwd;
      pathMappings = config.pathMappings;
    })
  else
    cb({
      type = 'executable';
      command = 'foo';
      args = { '-m', 'debugpy.adapter' };
      options = {
        source_filetype = 'python',
      };
    })
  end
end

dap.configurations.python = {
  {
    type = 'python';
    request = 'attach';
    name = 'Attach remote';
    connect = function()
			local config_index = vim.fn.inputlist({ 'Which config?', '1. Atlas','2. Atlas test' })
      local configs = {
        { host = 'khang-dbx', port = 56237 },
        { host = 'khang-dbx', port = 56234 }
      }

      local config = configs[config_index]

      -- local host = vim.fn.input('Host [khang-dbx]: ')
      -- host = host ~= '' and host or 'khang-dbx'
      -- local port = tonumber(vim.fn.input('Port [56237 (default) and 56234]: ')) or 56237
      return config
    end;
    cwd = vim.fn.getcwd();
    pathMappings = {
      {
        localRoot = vim.fn.getcwd();
        -- Same as WORKDIR on your devbox
        remoteRoot = "/home/khang/src/server-mirror"
      };
    };
  }
}

vim.fn.sign_define('DapBreakpoint', {text = '●', texthl = 'GruvboxRed', linehl = '', numhl = ''})

api.nvim_set_keymap('n', '<leader>dd', ":lua require('dap').continue()<CR>", {noremap = true})
api.nvim_set_keymap('n', '<leader>dbp', ":lua require('dap').toggle_breakpoint()<CR>", {noremap = true})
api.nvim_set_keymap('n', '<leader>de', ":lua require('dap').close()<CR>", {noremap = true})
api.nvim_set_keymap('n', '<leader>dc', ":lua require('dap').continue()<CR>", {noremap = true})
api.nvim_set_keymap('n', '<leader>dr', ":lua require('dap').repl.open({}, 'vsplit')<CR><C-w>la", {noremap = true})

api.nvim_set_keymap('n', 'J', ":lua require('debug-helper').step_over({fallback = 'J'})<CR>", {noremap = true})
api.nvim_set_keymap('n', 'L', ":lua require('debug-helper').step_into({fallback = 'L'})<CR>", {noremap = true})
api.nvim_set_keymap('n', 'K', ":lua require('debug-helper').step_out({fallback = 'K'})<CR>", {noremap = true})

dapui.setup({
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
})

vim.keymap.set('n', '<leader>dh', ":lua require('dapui').toggle()<CR>", { noremap = true, desc = "Toggle debug UI" })
vim.keymap.set('n', '<leader>de', ":lua require('dap').terminate()<CR>", { noremap = true, desc = "[D]ebug [E]xit" })
vim.keymap.set('n', '<leader>dj', ":lua require('dap').step_in()<CR>", { noremap = true, desc = "Step in" })
vim.keymap.set('n', '<leader>dk', ":lua require('dap').step_out()<CR>", { noremap = true, desc = "Step out" })
vim.keymap.set('n', '<leader>dl', ":lua require('dap').step_over()<CR>", { noremap = true, desc = "Step over" })
vim.keymap.set('n', '<leader>drc', ":lua require('dap').run_to_cursor()<CR>", { noremap = true, desc = "[D]ebug [R]un to [C]ursor" })
vim.keymap.set('n', '<leader>drl', ":lua require('dap').run_last()<CR>", { noremap = true, desc = "[D]ebug [R]un to [L]ast" })

-- dap.listeners.after.event_initialized['dapui_config'] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_exited['dapui_config'] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_stopped['dapui_config'] = function()
--   dapui.close()
-- end
-- -- dbx remote debugging needs these two config to close dap-ui
-- dap.listeners.before.disconnect["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.after.event_terminated['dapui_config'] = function()
--   dapui.close()
-- end
