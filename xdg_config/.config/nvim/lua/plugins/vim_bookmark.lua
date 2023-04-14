require("telescope").load_extension("vim_bookmarks")

local bookmark_actions = require("telescope").extensions.vim_bookmarks.actions
require("telescope").extensions.vim_bookmarks.all({
	attach_mappings = function(_, map)
		-- this doesn't work :(
		map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)
		return true
	end,
})
