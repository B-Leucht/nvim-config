-- Code editing and completion plugins
return {
	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = require("config.editor.treesitter"),
	},

	-- TODO comment highlighting
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = require("config.keys.todo-comments"),
		opts = {},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.editor.cmp")
		end,
	},

	-- Completion sources
	{ "hrsh7th/cmp-nvim-lsp", lazy = true },
	{ "hrsh7th/cmp-buffer", lazy = true },
	{ "hrsh7th/cmp-path", lazy = true },
	{ "hrsh7th/cmp-cmdline", lazy = true },
	{ "hrsh7th/cmp-nvim-lua", lazy = true },
	{
		"lukas-reineke/cmp-rg",
		lazy = true,
		enabled = function()
			return vim.fn.executable("rg") == 1
		end,
	},
	{ "SergioRibera/cmp-dotenv", lazy = true },
	{ "davidsierradz/cmp-conventionalcommits", lazy = true },
	{ "petertriho/cmp-git", lazy = true },
	{ "saadparwaiz1/cmp_luasnip", lazy = true },

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("config.editor.friendly-snippets")
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		ft = { "tex", "latex" },
		config = function()
			require("config.editor.latex-snippets")
		end,
	},

	-- Code formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = require("config.editor.conform"),
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.editor.nvim-lint")
		end,
	},

	-- AI assistance
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = require("config.editor.copilot"),
		keys = require("config.keys.copilot"),
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = {},
	},
}