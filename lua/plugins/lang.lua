-- Language-specific plugins
return {
	-- Rust support
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = "rust",
		init = function()
			vim.g.rustaceanvim = {
				server = {
					cmd = function()
						local mason_registry = require("mason-registry")
						local ra_binary = mason_registry.is_installed("rust-analyzer")
								and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
							or "rust-analyzer"
						return { ra_binary }
					end,
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		event = "BufRead Cargo.toml",
		ft = "toml",
		opts = require("config.lang.crates"),
	},

	-- LaTeX support
	{
		"lervag/vimtex",
		ft = { "tex", "latex", "bib" },
		keys = require("config.keys.vimtex"),
		init = function()
			require("config.lang.vimtex")
		end,
	},

	-- Markdown support
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		ft = "markdown",
		opts = {},
	},

	-- Mathematical notation rendering
	{
		"jbyuki/nabla.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"williamboman/mason.nvim",
		},
		ft = "markdown",
		keys = require("config.keys.nabla"),
	},
}