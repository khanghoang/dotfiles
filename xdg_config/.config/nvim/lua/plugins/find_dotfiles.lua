local M = {}
M.find_dotfiles = function()
    require("telescope.builtin").git_files({
        prompt_title = "< VimRC >",
        -- cwd = "~/.config/nvim",
        cwd = vim.env.DOTFILES,
        hidden = true,
        -- theme = "ivy",
        winblend = 10,
        width = 0.5,
        results_height = 15,
        previewer = false,
        -- layout_strategies = "vertical",
        -- layout_config = {
        --     height = 11,
        -- },
    })
end

return M
