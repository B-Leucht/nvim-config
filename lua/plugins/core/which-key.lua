return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		win = {
			border = "rounded",
			wo = {
				winblend = 0,
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader>b", group = "buffer" },
			{ "<leader>d", group = "debug" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>j", group = "java" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>m", group = "molten" },
			{ "<leader>n", group = "notes" },
			{ "<leader>o", group = "obsidian" },
			{ "<leader>O", group = "overseer" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>T", group = "test" },
			{ "<leader>u", group = "ui" },
			{ "<leader>vt", group = "vimtex" },
			{ "<leader>w", group = "windows" },
			{ "<leader>x", group = "execute" },
		})
	end,
}
