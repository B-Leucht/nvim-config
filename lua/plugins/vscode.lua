require("lazy").setup({
	-- Motion plugins only
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").set_default_mappings()
		end,
	},
	{ "monaqa/dial.nvim" },
	{
		"ggandor/flit.nvim",
		dependencies = { "ggandor/leap.nvim" },
		config = function()
			require("flit").setup()
		end,
	},

	-- Commenting (if VS Code's commenting isn't sufficient)
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Which-key for custom keymaps
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { preset = "helix" },
	},
})
