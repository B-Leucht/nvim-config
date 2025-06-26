-- Oil file manager keymaps
return {
	{ "-", function()
		local ft = vim.bo.filetype
		if ft == "snacks_terminal" or ft == "terminal" or ft == "claude" or ft == "trouble" then
			return
		end
		vim.cmd("Oil")
	end, desc = "Open parent directory" },
	{ "<leader>E", "<cmd>Oil --float<cr>", desc = "Open Oil in floating window" },
	{ "<leader>Er", function()
		vim.ui.input({ prompt = "Remote path (oil-ssh://user@host/path): " }, function(input)
			if input then
				vim.cmd("Oil " .. input)
			end
		end)
	end, desc = "Open remote directory in Oil" },
}