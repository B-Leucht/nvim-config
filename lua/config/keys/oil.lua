-- Oil file manager keymaps
return {
	{
		"-",
		function()
			local ft = vim.bo.filetype
			if ft == "snacks_terminal" or ft == "terminal" or ft == "trouble" then
				return
			end
			require("oil").open_float(nil, { preview = { update_on_cursor_moved = true } })
		end,
		desc = "Open parent directory",
	},
	{
		"<leader>fo",
		function()
			require("oil").open_float(nil, { preview = { update_on_cursor_moved = true } })
		end,
		desc = "Open oil (parent directory)",
	},
	{
		"<leader>fO",
		function()
			require("oil").open_float(vim.fn.getcwd(), { preview = { update_on_cursor_moved = true } })
		end,
		desc = "Open oil (cwd)",
	},
}
