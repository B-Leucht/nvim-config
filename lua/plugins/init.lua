require("lazy").setup({
	-- ===============================================
	-- COLORSCHEME & THEME
	-- ===============================================
	{
		"catppuccin/nvim",
		priority = 1000,
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
		config = function()
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.icons").setup()
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("config.snacks")
		end,
	},
	-- ===============================================
	-- NAVIGATION & MOVEMENT
	-- ===============================================
	-- Quick scope navigation
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
	},
	-- Number increment/decrement
	{ "monaqa/dial.nvim" },
	-- Smooth scrolling replaced by snacks.scroll

	-- ===============================================
	-- KEYBINDING HELPER
	-- ===============================================
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
		},
	},

	-- ===============================================
	-- LSP & LANGUAGE SUPPORT
	-- ===============================================
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("config.lsp.mason")
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("config.lsp.lspsaga")
		end,
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
		config = function()
			require("config.editor.treesitter")
		end,
	},
	-- Word highlighting replaced by snacks.words
	-- TODO comment highlighting
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- ===============================================
	-- AUTOCOMPLETION & SNIPPETS
	-- ===============================================
	{
		"hrsh7th/nvim-cmp",
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
	{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("config.editor.friendly-snippets")
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
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
		config = function()
			require("config.tools.sniprun")
		end,
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
		config = function()
			require("config.ui.numb")
		end,
	},

	-- ===============================================
	-- BUILD & COMPILATION
	-- ===============================================

	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		config = function()
			require("config.tools.overseer")
		end,
	},

	-- ===============================================
	-- CODE FORMATTING
	-- ===============================================
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.editor.conform")
		end,
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
		opts = {},
		-- Optional dependencies
		dependencies = { "echasnovski/mini.icons" }, -- use for file icons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("config.tools.oil")
		end,
	},
	-- {
	-- 	"echasnovski/mini.files",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("mini.files").setup()
	-- 	end,
	-- },

	{
		"refractalize/oil-git-status.nvim",

		dependencies = {
			"stevearc/oil.nvim",
		},

		config = true,
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"echasnovski/mini.icons",
		},
		config = function()
			require("config.tools.telescope")
		end,
	},

	-- ===============================================
	-- GIT INTEGRATION
	-- ===============================================
	-- Enhanced git diffs
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		config = function()
			require("config.tools.diffview")
		end,
	},
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
		config = function()
			require("config.ui.noice")
		end,
	},
	-- snacks.notifier replaces nvim-notify

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.ui.lualine")
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "echasnovski/mini.icons",
		config = function()
			require("config.ui.bufferline")
		end,
	},

	-- Buffer removal replaced by snacks.bufdelete

	{
		"folke/trouble.nvim",
		dependencies = { "echasnovski/mini.icons" },
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
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("config.editor.copilot")
		end,
	},

	-- Claude Code TUI integration
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("config.tools.claudecode")
		end,
	},

	-- ===============================================
	-- RUST SUPPORT
	-- ===============================================
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
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
		event = { "BufRead Cargo.toml" },
		config = function()
			require("config.lang.crates")
		end,
	},

	-- ===============================================
	-- LATEX SUPPORT
	-- ===============================================
	{
		"lervag/vimtex",
		config = function()
			require("config.lang.vimtex")
		end,
	},

	-- ===============================================
	-- MARKDOWN & DOCUMENTATION
	-- ===============================================
	-- Markdown preview
	{
		"OXY2DEV/markview.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("config.lang.markview")
		end,
	},

	-- Mathematical notation rendering
	{
		"jbyuki/nabla.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"williamboman/mason.nvim",
		},
	},
})
