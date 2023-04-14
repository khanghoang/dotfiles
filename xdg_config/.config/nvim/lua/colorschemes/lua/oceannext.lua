vim.cmd([[
  syntax enable
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  colorscheme OceanicNext
  set background=dark
]])

vim.g.airline_theme = "oceanicnext"

-- Visual studio code theme
vim.cmd([[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]])
vim.cmd([[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]])
vim.cmd([[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]])
vim.cmd([[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]])
vim.cmd([[highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE]])
vim.cmd([[highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE]])
vim.cmd([[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]])
vim.cmd([[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]])
vim.cmd([[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]])
vim.cmd([[highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4]])
vim.cmd([[highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4]])
