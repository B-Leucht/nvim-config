local constants = require("core.constants")

require("lazy").setup({
	-- ===============================================
	-- COLORSCHEME & THEME
	-- ===============================================
	{
		constants.APPEARANCE.THEME .. "/nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("config.ui.colorscheme")
		end,
	},
	-- ===============================================
	-- Libraries
	-- ===============================================

	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.icons").setup()
			-- require("mini.tabline").setup()
			-- require("mini.statusline").setup()
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = require("config.keys.snacks"),
		opts = require("config.snacks"),
	},
	-- ===============================================
	-- NAVIGATION & MOVEMENT
	-- ===============================================
	-- Quick scope navigation
	{
		"folke/flash.nvim",
		lazy = true,
		keys = require("config.keys.flash"),
		opts = {},
	},
	-- Number increment/decrement
	{
		"monaqa/dial.nvim",
		lazy = true,
		keys = require("config.keys.dial"),
	},
	-- Smooth scrolling replaced by snacks.scroll

	-- ===============================================
	-- KEYBINDING HELPER
	-- ===============================================
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		lazy = true,
		opts = {
			preset = "helix",
		},
	},

	-- ===============================================
	-- LSP & LANGUAGE SUPPORT
	-- ===============================================
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lsp.init")
		end,
		lazy = true,
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		build = ":MasonUpdate",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		opts = require("config.lsp.mason"),
	},
	{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = require("config.lsp.mason-tool-installer"),
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		keys = require("config.keys.lsp"),
		opts = require("config.lsp.lspsaga"),
	},
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},

	-- ===============================================
	-- SYNTAX HIGHLIGHTING
	-- ===============================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = require("config.editor.treesitter"),
	},
	-- Word highlighting replaced by snacks.words
	-- TODO comment highlighting
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = require("config.keys.todo-comments"),
		opts = {},
	},

	-- ===============================================
	-- AUTOCOMPLETION & SNIPPETS
	-- ===============================================
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("config.editor.cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lua", lazy = true },
	{
		"lukas-reineke/cmp-rg",
		lazy = true,
		enabled = function()
			return vim.fn.executable("rg") == 1
		end,
	},
	{ "SergioRibera/cmp-dotenv" },
	{ "davidsierradz/cmp-conventionalcommits" },
	{ "petertriho/cmp-git" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- Snippet engine and collections
	{ "L3MON4D3/LuaSnip", event = "InsertEnter", dependencies = { "rafamadriz/friendly-snippets" } },
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

	-- ===============================================
	-- CODE EDITING & UTILITIES
	-- ===============================================
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
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
	-- Search and replace across project
	-- {
	-- 	"nvim-pack/nvim-spectre",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("config.tools.spectre")
	-- 	end,
	-- },
	-- {
	-- 	"kevinhwang91/nvim-hlslens",
	-- 	config = function()
	-- 		require("config.ui.hlslens")
	-- 	end,
	-- },

	{
		"nacro90/numb.nvim",
		event = "CmdlineEnter",
		opts = {},
	},

	-- ===============================================
	-- BUILD & COMPILATION
	-- ===============================================

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

	-- ===============================================
	-- CODE FORMATTING
	-- ===============================================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = require("config.editor.conform"),
	},
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("config.editor.nvim-lint")
		end,
	},

	-- ===============================================
	-- FILE MANAGEMENT & SEARCH
	-- ===============================================
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { "echasnovski/mini.icons" }, -- use for file icons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		keys = require("config.keys.oil"),

		opts = require("config.tools.oil"),
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {},
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
	-- Fuzzy finder with snacks.picker
	-- (configured in snacks-dashboard.lua)
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

	-- ===============================================
	-- GIT INTEGRATION
	-- ===============================================
	-- Enhanced git diffs
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = require("config.keys.git"),
		opts = {},
	},
	-- -- Git signs
	-- {
	-- 	"lewis6991/gitsigns.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- },
	-- ===============================================
	-- UI ENHANCEMENTS
	-- ===============================================

	-- Indentation guides replaced by snacks.indent

	-- Terminal integration with snacks.nvim
	-- (configured in snacks-dashboard.lua)

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
	-- snacks.notifier replaces nvim-notify

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = require("config.ui.lualine"),
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "echasnovski/mini.icons",
		event = "VeryLazy",
		opts = require("config.ui.bufferline"),
	},

	-- Buffer removal replaced by snacks.bufdelete

	{
		"folke/trouble.nvim",
		dependencies = { "echasnovski/mini.icons" },
		keys = require("config.keys.trouble"),
		opts = function()
			local constants = require("core.constants")
			return {
				win = {
					size = {
						height = constants.UI.PANEL_HEIGHT,
						width = constants.UI.SIDEBAR_WIDTH,
					},
				},
			}
		end,
		cmd = "Trouble",
	},

	-- ===============================================
	-- AI ASSISTANCE
	-- ===============================================
	-- GitHub Copilot
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

	-- Claude Code TUI integration
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		keys = require("config.keys.claudecode"),
		opts = require("config.tools.claudecode"),
	},

	-- ===============================================
	-- RUST SUPPORT
	-- ===============================================
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

	-- ===============================================
	-- LATEX SUPPORT
	-- ===============================================
	{
		"lervag/vimtex",
		ft = { "tex", "latex", "bib" },
		keys = require("config.keys.vimtex"),
		init = function()
			require("config.lang.vimtex")
		end,
	},

	-- ===============================================
	-- MARKDOWN & DOCUMENTATION
	-- ===============================================
	-- Markdown preview
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
})
