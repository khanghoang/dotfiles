return {
  "NTBBloodbath/galaxyline.nvim",
  -- branch = 'main',
  -- event = { 'VimEnter' },
  config = function()
    local gl = require("galaxyline")
    local colors = require("galaxyline.themes.colors").default
    local condition = require("galaxyline.condition")
    local gls = gl.section
    local log = require("libs.log")

    local lspIcon = require("libs.icons").ui.ChevronRight

    local indicator = {
      "⠲",
      "⠴",
      "⠦",
      "⠖",
    }

    -- { client_id: spinner }
    local spinners = {}
    local get_spinner_data = function(client_id)
      local make_spinner = function()
        local timer = vim.loop.new_timer()
        local status = ""
        local i = 1

        return {
          start = function()
            -- log.debug(
            --   "Spinner starts",
            --   {}
            -- )
            timer:start(
              0, -- wait
              100, -- every
              vim.schedule_wrap(function()
                i = i < #indicator and i + 1 or 1
                status = " " .. indicator[i] .. " "
              end)
            )
          end,
          stop = function()
            status = ""
            timer:stop()
          end,
          get_status = function()
            return status
          end,
        }
      end

      if not spinners[client_id] then
        spinners[client_id] = make_spinner()
        -- log.debug('create spinner with id', { client_id = client_id, spinner = spinners[client_id] })
        return spinners[client_id]
      end

      return spinners[client_id]
    end

    vim.lsp.handlers["$/progress"] = function(err, result, ctx)
      -- See: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#progress

      -- log.debug(
      --   "Received progress notification:",
      --   { err = err, result = result, ctx = ctx }
      -- )

      local client_id = ctx.client_id
      local val = result.value

      if not val.kind then
        return
      end

      local s = get_spinner_data(client_id)

      -- log.debug(
      --   "Get spinner",
      --   { spinner = s }
      -- )

      if val.kind == "begin" then
        s.start()
      elseif val.kind == "report" and s then
        -- do nothing, for now
      elseif val.kind == "end" and s then
        s.stop()
      end
    end

    local lspIcon = require("libs.icons").ui.ChevronRight

    local get_lsp_client = function(msg)
      msg = msg or ""
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end

      for _, client in ipairs(clients) do
        -- log.debug("client id", { client_id = client.id })
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          local s = get_spinner_data(client.id)
          msg = msg .. " " .. s.get_status() .. client.name
        end
      end
      return msg
    end

    -- Default colors and providers
    -- https://github.com/glepnir/galaxyline.nvim#default-provider-groups

    gls.left[3] = {
      DiagnosticError = {
        condition = condition.buffer_not_empty,
        provider = "DiagnosticError",
        icon = " ",
        separator = "",
        highlight = { colors.red, colors.bg },
        separator_highlight = { "NONE", colors.bg },
      },
    }
    gls.left[4] = {
      DiagnosticWarn = {
        condition = condition.buffer_not_empty,
        provider = "DiagnosticWarn",
        icon = " ",
        highlight = { colors.yellow, colors.bg },
        separator_highlight = { "NONE", colors.bg },
      },
    }

    gls.left[5] = {
      DiagnosticHint = {
        condition = condition.buffer_not_empty,
        provider = "DiagnosticHint",
        icon = " ",
        highlight = { colors.cyan, colors.bg },
        separator_highlight = { "NONE", colors.bg },
      },
    }

    gls.left[6] = {
      DiagnosticInfo = {
        condition = condition.buffer_not_empty,
        provider = "DiagnosticInfo",
        icon = " ",
        highlight = { colors.blue, colors.bg },
        separator_highlight = { "NONE", colors.bg },
      },
    }

    gls.left[7] = {
      ShowLspClient = {
        provider = get_lsp_client,
        condition = condition.buffer_not_empty,
        icon = " " .. lspIcon,
        highlight = { colors.cyan, colors.bg },
        separator_highlight = { "NONE", colors.bg },
        separator = "  ",
      },
    }

    gls.right[2] = {
      DiffAdd = {
        provider = "DiffAdd",
        icon = "+",
        highlight = { colors.green, colors.bg },
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
      },
    }
    gls.right[3] = {
      DiffModified = {
        provider = "DiffModified",
        icon = "~",
        highlight = { colors.orange, colors.bg },
      },
    }
    gls.right[4] = {
      DiffRemove = {
        provider = "DiffRemove",
        icon = "-",
        highlight = { colors.red, colors.bg },
      },
    }

    gls.right[5] = {
      LinePercent = {
        provider = "LinePercent",
        icon = "↓",
        separator = "",
        separator_highlight = { "NONE", colors.bg },
        highlight = { colors.blue, colors.bg, "bold" },
      },
    }

    gls.mid[1] = {
      GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        highlight = { "#6e6763", "#352f2d" },
        separator_highlight = { "NONE", colors.bg },
      },
    }

    gls.mid[2] = {
      FileName = {
        provider = function()
          local filepath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
          return filepath
        end,
        condition = condition.buffer_not_empty,
        highlight = { "#b4bdc3", "#352f2d" },
        separator = " - ",
        separator_highlight = { "NONE", "#352f2d" },
        icon_highlight = { "NONE", "#352f2d" },
      },
    }

    vim.cmd([[hi StatusLine guibg=#352f2d guifg=#352f2d]])
  end,
  dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
}
