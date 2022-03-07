local gl = require('galaxyline')
local colors = require('galaxyline.themes.colors').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'packer'}

gls.right[1] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.left[2] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta,colors.bg,'bold'}
  }
}

gls.left[3] = {
  DiagnosticError = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticError',
    icon = ' E:',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[4] = {
  DiagnosticWarn = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticWarn',
    icon = ' W:',
    highlight = {colors.yellow,colors.bg},
  }
}

gls.left[5] = {
  DiagnosticHint = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticHint',
    icon = ' H:',
    highlight = {colors.cyan,colors.bg},
  }
}

gls.left[6] = {
  DiagnosticInfo = {
    condition = condition.buffer_not_empty,
    provider = 'DiagnosticInfo',
    icon = ' I:',
    highlight = {colors.blue,colors.bg},
  }
}

gls.left[7] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = condition.buffer_not_empty,
    icon = ' LSP:',
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}

gls.right[1] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[2] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '+',
    highlight = {colors.green,colors.bg},
  }
}
gls.right[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = '~',
    highlight = {colors.orange,colors.bg},
  }
}
gls.right[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '-',
    highlight = {colors.red,colors.bg},
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
