-- Navigation and movement plugins
return {
	-- Quick scope navigation
	{
		"folke/flash.nvim",
		lazy = true,
		keys = require("config.keys.flash"),
		opts = {},
	},

	-- Keybinding helper
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {
			preset = "helix",
		},
	},
}

