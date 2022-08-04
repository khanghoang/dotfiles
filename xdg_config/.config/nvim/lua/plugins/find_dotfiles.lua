local M = {}
M.find_dotfiles = function()
    require("telescope.builtin").git_files({
        prompt_title = "< VimRC >",
        -- cwd = "~/.config/nvim",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end

return M
