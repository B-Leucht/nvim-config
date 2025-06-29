-- Git integration plugins
return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = require("config.keys.git"),
		opts = {},
	},
}