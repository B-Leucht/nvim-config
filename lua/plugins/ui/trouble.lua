-- Trouble diagnostics
return {
	"folke/trouble.nvim",
	dependencies = { "echasnovski/mini.icons" },
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle win.position=bottom<cr>",
			desc = "Diagnostics (Trouble)",
		},

		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0 win.position=bottom<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},

		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
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

