-- Todo comments navigation keymaps
return {
	{
		"]t",
		function()
			require("todo-comments").jump_next()
		end,
		desc = "Next todo comment",
	},
	{
		"[t",
		function()
			require("todo-comments").jump_prev()
		end,
		desc = "Previous todo comment",
	},
}

