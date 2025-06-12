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
	{
		"unblevable/quick-scope",
		config = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
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
	-- Tree sinter
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
	{ "petertriho/cmp-git" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		opts = {
			-- add any options here
		},
	},
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
	--{
	--	"nvim-telescope/telescope.nvim",
	--	dependencies = {
	--		"nvim-lua/plenary.nvim",
	--		"nvim-tree/nvim-web-devicons",
	--	},
	--	config = function()
	--		require("config.telescope")
	--	end,
	--},
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
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("config.noice")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "fade", -- Or "static" for no animation
				timeout = 1500, -- Shorter display time (in ms)
				background_colour = "#1E1E2E", -- Transparent or dark background
				render = "minimal", -- Minimal rendering style
				top_down = false, -- Newest notifications at the bottom
			})
		end,
	},
	--{
	--	"gelguy/wilder.nvim",
	--	event = "CmdlineEnter",
	--	config = function()
	--		require("config.wilder")
	--	end,
	--},
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
	{
		"yetone/avante.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = { file_types = { "markdown", "Avante" } },
				ft = { "markdown", "Avante" },
			},
		},
		build = "make",
		opts = {
			provider = "copilot",
			PROVIDERS = {
				ollama = {
					endpoint = "http://localhost:11434",
					model = "codellama",
				},
			},
		},
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
	--	{
	--		"OXY2DEV/markview.nvim",
	--		dependencies = { "nvim-treesitter/nvim-treesitter" },
	--		config = function()
	--			require("config.markview")
	--		end,
	--	},
	--	{
	--		"jbyuki/nabla.nvim",
	--		dependencies = {
	--			"nvim-treesitter/nvim-treesitter",
	--			"williamboman/mason.nvim",
	--		},
	--	},
})
