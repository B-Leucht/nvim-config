-- Claude Code AI assistance keymaps
return {
	{ "<leader>ac", function()
		-- Check if symbols trouble is open in right sidebar
		local symbols_win = nil
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local name = vim.api.nvim_buf_get_name(buf)
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
			if ft == "trouble" and name:match("symbols") then
				symbols_win = win
				break
			end
		end
		if symbols_win then
			vim.api.nvim_win_close(symbols_win, false)
		end
		vim.cmd("ClaudeCode")
	end, desc = "Toggle Claude" },
	{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
	{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
	{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
	{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
	{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Send to Claude", mode = "v" },
	{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
	{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
}