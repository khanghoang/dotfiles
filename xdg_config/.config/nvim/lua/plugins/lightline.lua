local gl = require('galaxyline')
local colors = require('galaxyline.themes.colors').default
local condition = require('galaxyline.condition')
local gls = gl.section
local M = {}

local lspIcon = require "plugins.icons".ui.ChevronRight

local i = 1
local time = 1
local status = '';
local spinner = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  }

local timer = vim.loop.new_timer()
timer:start(
  200,
  200,
  vim.schedule_wrap(function()
    i = i < 10 and i + 1 or 1
    time = time + 1
    status = ' '..spinner[i]..' '
    if (time == 20) then
      timer:stop()
      status = ''
    end
  end)
)

function split(pString, pPattern)
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end

gls.left[3] = {
  DiagnosticError = {
    condition = condition.buffer_not_empty,
    provider = function ()
      return status
    end,
    icon = ' ',
    separator = '',
    highlight = {colors.yellow,colors.bg},
    separator_highlight = {'NONE',colors.bg},
  }
}
gls.left[4] = {
  DiagnosticWarn = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticWarn',
    icon = ' ',
    highlight = {colors.yellow,colors.bg},
    separator_highlight = {'NONE',colors.bg},
  }
}

gls.left[5] = {
  DiagnosticHint = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticHint',
    icon = ' ',
    highlight = {colors.cyan,colors.bg},
    separator_highlight = {'NONE',colors.bg},
  }
}

gls.left[6] = {
  DiagnosticInfo = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticInfo',
    icon = ' ',
    highlight = {colors.blue,colors.bg},
    separator_highlight = {'NONE',colors.bg},
  }
}

gls.left[7] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = condition.buffer_not_empty,
    icon = ' ' .. lspIcon,
    highlight = {colors.cyan,colors.bg},
    separator_highlight = {'NONE',colors.bg},
    separator = "  ",
  }
}

gls.right[2] = {
  DiffAdd = {
    provider = 'DiffAdd',
    icon = '+',
    highlight = {colors.green,colors.bg},
    separator = " ",
    separator_highlight = {'NONE',colors.bg},
  }
}
gls.right[3] = {
  DiffModified = {
    provider = 'DiffModified',
    icon = '~',
    highlight = {colors.orange,colors.bg},
  }
}
gls.right[4] = {
  DiffRemove = {
    provider = 'DiffRemove',
    icon = '-',
    highlight = {colors.red,colors.bg},
  }
}

gls.right[5] = {
  LinePercent = {
    provider = 'LinePercent',
    icon = '↓',
    separator = '',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.mid[1] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {"#6e6763", "#352f2d"},
    separator_highlight = {'NONE',colors.bg},
  }
}

gls.mid[2] = {
  FileName = {
    provider = function ()
      local filepath = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
      local table = split(filepath, '/')
      local str = ''
      for i = 1, #table-1, 1 do
        str = str .. table[i]:sub(1,1) .. '/'
      end
        str = str .. table[#table]
      return str
    end,
    -- provider = 'FilePath',
    condition = condition.buffer_not_empty,
    highlight = {"#b4bdc3", "#352f2d"},
    separator = ' - ',
    separator_highlight = {'NONE', "#352f2d"},
    icon_highlight = {'NONE', "#352f2d"},
  }
}

vim.cmd [[hi StatusLine guibg=#352f2d guifg=#352f2d]]

M.reload = function ()
  local gl = require('galaxyline')
  local gls = gl.section

  gls.right = {}
  gls.left= {}

  require("plenary.reload").reload_module("NTBBloodbath/galaxyline.nvim")
  require("plenary.reload").reload_module("plugins.lightline")
  require("plugins.lightline")

 print('reloaded')
end

return M
