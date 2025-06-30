-- Trouble diagnostics
return {
	"folke/trouble.nvim",
	dependencies = { "echasnovski/mini.icons" },
	keys = {
		-- Smart diagnostics trouble - shares bottom panel with terminal
		{
			"<leader>xx",
			function()
				-- Check if terminal is open in bottom panel
				local term_win = nil
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
					local name = vim.api.nvim_buf_get_name(buf)
					if ft == "snacks_terminal" or name:match("term://") then
						term_win = win
						break
					end
				end

				if term_win then
					-- Close terminal and open diagnostics in same position
					vim.api.nvim_win_close(term_win, false)
				end
				vim.cmd("Trouble diagnostics toggle win.position=bottom")
			end,
			desc = "Diagnostics (Trouble)",
		},

		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0 win.position=bottom<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},

		-- Smart symbols trouble - replaces Claude if open
		{
			"<leader>xs",
			function()
				-- Check if Claude is open in right sidebar
				local claude_win = nil
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
					local name = vim.api.nvim_buf_get_name(buf)
					local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
					if ft == "claude" or name:match("claude") or bt == "terminal" and name:match("claude") then
						claude_win = win
						break
					end
				end

				if claude_win then
					-- Close Claude and open symbols in same position
					vim.api.nvim_win_close(claude_win, false)
					vim.cmd("Trouble symbols toggle focus=false win.position=right")
				else
					-- Normal symbols toggle
					vim.cmd("Trouble symbols toggle focus=false")
				end
			end,
			desc = "Symbols (Trouble)",
		},

		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
	opts = {
		win = {
			size = {
				height = require("core.constants").UI.PANEL_HEIGHT,
				width = require("core.constants").UI.SIDEBAR_WIDTH,
			},
		},
	},
}

