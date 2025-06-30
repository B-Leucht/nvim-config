-- ===============================================
-- NAVIGATION & MOVEMENT
-- ===============================================
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = false, -- Disable search mode to avoid conflicts with VS Code search
			},
			char = {
				enabled = true,
				jump_labels = true,
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}