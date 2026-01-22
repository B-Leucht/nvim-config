-- Keybinding helper
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	lazy = true,
	opts = {
		preset = "helix",
		win = {
			border = "rounded",
			wo = {
				winblend = 0,
			},
		},
	},
}