local gl = require('galaxyline')
local colors = require('galaxyline.themes.colors').default
local condition = require('galaxyline.condition')
local gls = gl.section
local M = {}

-- Default colors and providers
-- https://github.com/glepnir/galaxyline.nvim#default-provider-groups

gls.left[3] = {
  DiagnosticError = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticError',
    icon = ' ',
    separator = '',
    highlight = {colors.red,colors.bg},
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
    icon = ' LSP:',
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
      return filepath
    end,
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
