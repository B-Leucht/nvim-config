-- Sniprun code execution keymaps
return {
	{ "<leader>r", "<Plug>SnipRun", desc = "Run code snippet", mode = { "n", "v" } },
	{ "<leader>rc", "<Plug>SnipClose", desc = "Close sniprun" },
	{ "<leader>rt", "<Plug>SnipTerminate", desc = "Terminate sniprun" },
}