local g = vim.g
local api = vim.api

g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "h",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
}

vim.api.nvim_set_keymap('n', '<C-p>', ':SymbolsOutline<CR>', {noremap = true})
