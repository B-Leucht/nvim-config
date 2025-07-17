-- Session persistence
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	config = {
		dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
		-- minimum number of file buffers that need to be open to save
		-- Set to 0 to always save
		need = 1,
		branch = true, -- use git branch to save session
	},
	keys = {
		-- load the session for the current directory
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
		},

		-- select a session to load
		{
			"<leader>qS",
			function()
				require("persistence").select()
			end,
		},

		-- load the last session
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
		},

		-- stop Persistence => session won't be saved on exit
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
		},
	},
}
