-- Development tools and utilities
return {
	-- Session persistence
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
	},

	-- Code execution
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		dependencies = { "folke/snacks.nvim" },
		keys = require("config.keys.sniprun"),
		opts = require("config.tools.sniprun"),
	},

	-- Search and replace
	{
		"MagicDuck/grug-far.nvim",
		keys = require("config.keys.grug-far"),
		opts = require("config.tools.grug-far"),
	},

	-- Build and compilation
	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		keys = require("config.keys.compiler"),
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = require("config.tools.overseer"),
	},

	-- File management
	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.icons" },
		lazy = false,
		keys = require("config.keys.oil"),
		opts = require("config.tools.oil"),
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},

	-- Telescope (for compiler.nvim)
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.icons",
		},
		opts = require("config.tools.telescope"),
	},

	-- Claude Code integration
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		keys = require("config.keys.claudecode"),
		opts = require("config.tools.claudecode"),
	},
}

