-- Code execution
return {
	"michaelb/sniprun",
	branch = "master",
	build = "sh install.sh",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{ "<leader>r", "<Plug>SnipRun", desc = "Run code snippet", mode = { "n", "v" } },
		{ "<leader>rc", "<Plug>SnipClose", desc = "Close sniprun" },
		{ "<leader>rt", "<Plug>SnipTerminate", desc = "Terminate sniprun" },
	},
	opts = {
		display = { "TerminalOk" },
		display_options = {
			notification_timeout = 1500,
		},
		selected_interpreters = {},
	},
}