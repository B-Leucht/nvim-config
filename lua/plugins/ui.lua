-- UI Enhancement plugins
local constants = require("core.constants")

return {
	-- Colorscheme
	{
		constants.APPEARANCE.THEME .. "/nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("config.ui.colorscheme")
		end,
	},

	-- Enhanced UI messages
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"folke/snacks.nvim",
		},
		opts = require("config.ui.noice"),
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
        dependencies = {"folke/trouble.nvim"},
		event = "VeryLazy",
		opts = require("config.ui.lualine"),
	},

	-- Buffer line
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "*",
	-- 	dependencies = "echasnovski/mini.icons",
	-- 	event = "VeryLazy",
	-- 	opts = require("config.ui.bufferline"),
	-- },

	-- Trouble diagnostics
	{
		"folke/trouble.nvim",
		dependencies = { "echasnovski/mini.icons" },
		keys = require("config.keys.trouble"),
		opts = { win = {
					size = {
						height = constants.UI.PANEL_HEIGHT,
						width = constants.UI.SIDEBAR_WIDTH,
					},
				},
			}
	},

	-- Line number peek
	{
		"nacro90/numb.nvim",
		event = "CmdlineEnter",
		opts = {},
	},
}
