return {
  "mfussenegger/nvim-dap",
  "Weissle/persistent-breakpoints.nvim",
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local is_port_available = require("libs.check_port").is_port_available

      -- This has to be "." in order to have the buffer path opened
      -- correctly when debugging (ie. lsp and treesitter work)
      local dbx_remote_dir = "."
      --
      local api = vim.api
      local installation_path = vim.fn.stdpath("data") .. "/mason/bin"
      local notify = require("libs.notify")
      local job = require("plenary.job")

      -- config for persistent-breakpoints
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })

      -- May need to symlink manually, for example
      -- ln -sf ~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3 ~/.local/share/nvim/mason/bin/
      -- Though for debugpy, it needs the full path of the even python3, and
      -- I still don't know why
      dap.adapters.python = function(cb, config)
        -- example to debug in DOCKER
        -- https://github.com/awwalker/nvim-dap/pull/1/files
        if config.request == "attach" then
          local port = (config.connect or config).port
          cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = (config.connect or config).host or "127.0.0.1",
            cwd = config.cwd,
            pathMappings = config.pathMappings,
          })
        else
          cb({
            type = "executable",
            command = "foo",
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          })
        end
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "attach",
          name = "Attach remote",
          connect = function()
            local config_index = vim.fn.inputlist({ "Which config?", "1. Atlas", "2. Atlas test" })
            local configs = {
              -- { host = 'khang-dbx', port = 56237 },
              -- { host = 'khang-dbx', port = 56234 }
              { host = "localhost", port = 56237 },
              { host = "localhost", port = 56234 },
            }

            local config = configs[config_index]
            if is_port_available(config.port) then
              print(
                "Local port " .. config.port .. " is still open. Need to forward port from devbox"
              )
              local should_forward_port = vim.fn.input("We're cool? [Y]/n ") or "Y"
              if
                should_forward_port == "Y"
                or should_forward_port == "y"
                or should_forward_port == ""
              then
                -- @TODO: handle ssh failure
                os.execute(
                  "ssh -L "
                    .. tostring(config.port)
                    .. ":$USER-dbx:"
                    .. tostring(config.port)
                    .. " -N -f $USER-dbx"
                )
              else
                assert(false, "Need forward port")
              end
            end

            return config
          end,
          cwd = vim.fn.getcwd(),
          pathMappings = {
            {
              localRoot = vim.fn.getcwd(),
              remoteRoot = dbx_remote_dir,
            },
          },
        },
      }

      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      require("dap-vscode-js").setup({
        node_path = "node",
        debugger_path = os.getenv("HOME") .. "/.DAP/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })

      local exts = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        -- using pwa-chrome
        "vue",
        "svelte",
      }

      for i, ext in ipairs(exts) do
        dap.configurations[ext] = {
          -- this one works with nextjs
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach Program (pwa-node)",
            cwd = vim.fn.getcwd(),
            -- processId = require('dap.utils').pick_process,
            skipFiles = { "<node_internals>/**" },
            host = "localhost",
            port = 9229,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node)",
            cwd = vim.fn.getcwd(),
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with ts-node)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "--loader", "ts-node/esm" },
            runtimeExecutable = "node",
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with jest)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
            runtimeExecutable = "node",
            args = { "${file}", "--coverage", "false" },
            rootPath = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with vitest)",
            cwd = vim.fn.getcwd(),
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
            autoAttachChildProcesses = true,
            smartStep = true,
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Program (pwa-chrome = { port: 9222 })",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = 9222,
            webRoot = "${workspaceFolder}",
          },
          {
            type = "node2",
            request = "attach",
            name = "Attach Program (Node2)",
            processId = require("dap.utils").pick_process,
          },
          {
            type = "node2",
            request = "attach",
            name = "Attach Program (Node2 with ts-node)",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
            port = 9229,
          },
        }
      end

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "●", texthl = "GruvboxRed", linehl = "", numhl = "" }
      )

      api.nvim_set_keymap(
        "n",
        "<leader>dd",
        ":lua require('dap').continue()<CR>",
        { noremap = true }
      )
      api.nvim_set_keymap(
        "n",
        "<leader>dbp",
        ":lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>",
        { noremap = true }
      )
      api.nvim_set_keymap("n", "<leader>de", ":lua require('dap').close()<CR>", { noremap = true })
      api.nvim_set_keymap(
        "n",
        "<leader>dc",
        ":lua require('dap').continue()<CR>",
        { noremap = true }
      )
      api.nvim_set_keymap(
        "n",
        "<leader>dr",
        ":lua require('dap').repl.open({}, 'vsplit')<CR><C-w>la",
        { noremap = true }
      )

      -- api.nvim_set_keymap('n', 'J', ":lua require('debug-helper').step_over({fallback = 'J'})<CR>", {noremap = true})
      -- api.nvim_set_keymap('n', 'L', ":lua require('debug-helper').step_into({fallback = 'L'})<CR>", {noremap = true})
      -- api.nvim_set_keymap('n', 'K', ":lua require('debug-helper').step_out({fallback = 'K'})<CR>", {noremap = true})

      dapui.setup({
        layouts = {
          {
            elements = {
              "scopes",
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              -- "console",
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      vim.keymap.set(
        "n",
        "<leader>dh",
        ":lua require('dapui').toggle()<CR>",
        { noremap = true, desc = "Toggle debug UI" }
      )
      vim.keymap.set(
        "n",
        "<leader>de",
        ":lua require('dap').terminate()<CR>",
        { noremap = true, desc = "[D]ebug [E]xit" }
      )
      vim.keymap.set(
        "n",
        "<leader>dj",
        ":lua require('dap').step_into()<CR>",
        { noremap = true, desc = "Step in" }
      )
      vim.keymap.set(
        "n",
        "<leader>dk",
        ":lua require('dap').step_out()<CR>",
        { noremap = true, desc = "Step out" }
      )
      vim.keymap.set(
        "n",
        "<leader>dl",
        ":lua require('dap').step_over()<CR>",
        { noremap = true, desc = "Step over" }
      )
      vim.keymap.set(
        "n",
        "<leader>drc",
        ":lua require('dap').run_to_cursor()<CR>",
        { noremap = true, desc = "[D]ebug [R]un to [C]ursor" }
      )
      vim.keymap.set(
        "n",
        "<leader>drl",
        ":lua require('dap').run_last()<CR>",
        { noremap = true, desc = "[D]ebug [R]un to [L]ast" }
      )
      vim.keymap.set(
        "n",
        "<leader>dbc",
        ":lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>",
        { noremap = true, desc = "[D]ebug [B]reakpoint [C]ondition" }
      )

      vim.keymap.set(
        "n",
        "<leader>dbx",
        ":lua require('persistent-breakpoints.api').clear_all_breakpoints()<CR>",
        { noremap = true, desc = "[D]ebug [B]reakpoint [X]kill" }
      )

      -- Check value
      vim.keymap.set("n", "L", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
      vim.keymap.set("v", "L", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })

      local function clear_virtual_dap_text(session)
        session = session or dap.session()
        local virtual_text = require("nvim-dap-virtual-text/virtual_text")
        if session and session.threads and session.threads[session.stopped_thread_id] then
          local frames = session.threads[session.stopped_thread_id].frames
          virtual_text.clear_virtual_text()
          for _, f in pairs(frames or {}) do
            virtual_text.set_virtual_text(f, {}, false)
          end
        else
          if session and session.current_frame then
            virtual_text.set_virtual_text(session.current_frame, {}, true)
          end
        end
        virtual_text.clear_virtual_text()
      end

      -- List available events in DAP
      -- https://github.com/mfussenegger/nvim-dap/blob/a6d48d23407fbad7a4c1451803b8f34cab31c441/lua/dap.lua#L38-L96
      -- This won't work since PTVSD doesn't fully implement DAP protocol
      dap.listeners.before["event_exited"]["dbx-dap"] = function(session, body)
        print("Session exited!!", vim.inspect(session), vim.inspect(body))
        -- clear_virtual_dap_text(session)
      end
      dap.listeners.before.disconnect["dapui_config"] = function()
        -- clear_virtual_dap_text()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        -- dapui.close()
        -- clear_virtual_dap_text()
      end
      dap.listeners.before.event_stopped["dapui_config"] = function()
        job
          :new({
            -- cwd = "/Users/khang/code/server",
            command = "bring_kitty_to_front",
          })
          :start()
      end

      vim.api.nvim_create_user_command("RemoveVirtualText", function()
        clear_virtual_dap_text()
      end, { nargs = "*" })
    end,
    dependencies = { "rcarriga/nvim-dap-ui" },
  },
  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npm run compile",
  },
  { "jbyuki/one-small-step-for-vimkind" },
}
