-- Code execution
return {
	"michaelb/sniprun",
	branch = "master",
	build = "sh install.sh",
	dependencies = { "folke/snacks.nvim" },
	keys = {
		{ "<leader>xr", "<Plug>SnipRun", desc = "Sniprun", mode = { "n", "v" } },
		{ "<leader>xc", "<Plug>SnipClose", desc = "Close Sniprun" },
		{ "<leader>xx", "<Plug>SnipTerminate", desc = "Terminate Sniprun" },
	},
	opts = {
		display = { "TerminalOk" },
		display_options = {
			notification_timeout = 1500,
		},
		selected_interpreters = {},
	},
}