-- Core and essential plugins
return {
	-- Mini.nvim collection
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()
		end,
	},

	-- Snacks.nvim - modern plugin collection
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = require("config.keys.snacks"),
		opts = require("config.snacks"),
	},
}