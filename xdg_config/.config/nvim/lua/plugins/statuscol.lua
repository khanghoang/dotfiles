local builtin = require("statuscol.builtin")
local cfg = {
  -- Whether to set the 'statuscolumn' option, may be set to false for those who
  -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
  -- Although I recommend just using the segments field below to build your
  -- statuscolumn to benefit from the performance optimizations in this plugin.
  setopt = true,
  -- builtin.lnumfunc number string options
  thousands = false,     -- or line number thousands separator string ("." / ",")
  relculright = false,   -- whether to right-align the cursor line number with 'relativenumber' set
  -- Builtin 'statuscolumn' options
  ft_ignore = {
    "startify",
    "dashboard",
    "dotooagenda",
    "log",
    "fugitive",
    "gitcommit",
    "packer",
    "vimwiki",
    "markdown",
    "json",
    "txt",
    "vista",
    "help",
    "todoist",
    "NvimTree",
    "peekaboo",
    "git",
    "TelescopePrompt",
    "undotree",
    "flutterToolsOutline",
    "dbui",
    "dbout",
    "sql",
    "" -- for all buffers without a file type
  },       -- lua table with filetypes for which 'statuscolumn' will be unset
  bt_ignore = { "nofile" },       -- lua table with 'buftype' values for which 'statuscolumn' will be unset
  -- Default segments (fold -> sign -> line number + separator), explained below
  segments = {
    { text = { "%s" }, click = "v:lua.scsa",  },
    {
      text = { builtin.lnumfunc }, click = "v:lua.scla",
      condition = { builtin.not_empty, true, builtin.not_empty },
    },
    {
      text = { builtin.foldfunc },
      condition = { builtin.not_empty, true, builtin.not_empty },
      click = "v:lua.scfa"
    },
  },
  clickhandlers = {       -- builtin click handlers
  Lnum                   = builtin.lnum_click,
  FoldClose              = builtin.foldclose_click,
  FoldOpen               = builtin.foldopen_click,
  FoldOther              = builtin.foldother_click,
  DapBreakpointRejected  = builtin.toggle_breakpoint,
  DapBreakpoint          = builtin.toggle_breakpoint,
  DapBreakpointCondition = builtin.toggle_breakpoint,
  DiagnosticSignError    = builtin.diagnostic_click,
  DiagnosticSignHint     = builtin.diagnostic_click,
  DiagnosticSignInfo     = builtin.diagnostic_click,
  DiagnosticSignWarn     = builtin.diagnostic_click,
  GitSignsTopdelete      = builtin.gitsigns_click,
  GitSignsUntracked      = builtin.gitsigns_click,
  GitSignsAdd            = builtin.gitsigns_click,
  GitSignsChange         = builtin.gitsigns_click,
  GitSignsChangedelete   = builtin.gitsigns_click,
  GitSignsDelete         = builtin.gitsigns_click,
}
      }

      require("statuscol").setup(cfg)
