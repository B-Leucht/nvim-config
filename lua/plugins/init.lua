require("lazy").setup({
	-- Theme
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			require("config.colorscheme")
		end,
	},
	-- Quick scope
	{ "unblevable/quick-scope" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- LSP & Mason
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("config.mason")
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- You already have this
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("lspsaga").setup({})
		end,
	},
	{
		"onsails/lspkind.nvim",
		lazy = true,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		--dependencies = { "OXY2DEV/markview.nvim" },
		config = function()
			require("config.treesitter")
		end,
	},

	-- CMP & snippets
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("config.cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		config = function()
			require("luasnip-latex-snippets").setup({
				use_treesitter = false, -- optional, but improves snippet context detection
			})
			require("luasnip").config.setup({ enable_autosnippets = true })
		end,
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "tpope/vim-commentary" },
	-- Formatter
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.conform")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("config.nvimtree")
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },

	-- FZF
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.fzf")
		end,
	},

	{ "nanotee/zoxide.vim" },

	-- Git
	{ "tpope/vim-fugitive" },
	{ "lewis6991/gitsigns.nvim", config = true },

	-- Start screen
	{
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
	},
	-- UI
	{
		"gelguy/wilder.nvim",
		config = function()
			require("config.wilder")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("config.bufferline")
		end,
	},

	-- Copilot
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("config.copilot")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
	},
	--	{
	--		"CopilotC-Nvim/CopilotChat.nvim",
	--		dependencies = {
	--			{ "zbirenbaum/copilot.lua" },
	--			{ "nvim-lua/plenary.nvim" },
	--		},
	--		build = "make tiktoken", -- Only on macOS or Linux
	--	},
	-- VimTeX
	{
		"lervag/vimtex",
		config = function()
			require("config.vimtex")
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("config.markview")
		end,
	},
	{
		"jbyuki/nabla.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"williamboman/mason.nvim",
		},
	},
})
