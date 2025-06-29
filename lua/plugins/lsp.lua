-- LSP and Language Server support plugins
return {
	-- Core LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lsp.init")
		end,
		lazy = true,
	},

	-- Mason package manager
	{
		"williamboman/mason.nvim",
		lazy = true,
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		opts = require("config.lsp.mason"),
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = require("config.lsp.mason-tool-installer"),
	},

	-- LSP kind icons
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},

	-- Lua development
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
