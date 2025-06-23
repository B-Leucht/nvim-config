require("lazy").setup({
	-- ===============================================
	-- COLORSCHEME & THEME
	-- ===============================================
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			require("config.colorscheme")
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
	-- Zoxide integration
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true,
				stop_eof = true,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
			})
		end,
	},

	-- ===============================================
	-- KEYBINDING HELPER
	-- ===============================================
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

	-- ===============================================
	-- LSP & LANGUAGE SUPPORT
	-- ===============================================
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
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
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

	-- ===============================================
	-- SYNTAX HIGHLIGHTING
	-- ===============================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.illuminate")
		end,
	},
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
			require("config.cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lua", lazy = true },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
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
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		config = function()
			require("luasnip-latex-snippets").setup({
				use_treesitter = false,
			})
			require("luasnip").config.setup({ enable_autosnippets = true })
		end,
	},

	-- ===============================================
	-- CODE EDITING & UTILITIES
	-- ===============================================
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		opts = {},
	},

	-- Code execution
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		dependencies = { "rcarriga/nvim-notify" },
		config = function()
			require("sniprun").setup({
				display = { "NvimNotify" },
				display_options = {
					notification_timeout = 1500, -- matches your notify config
				},
				-- Optional: specify interpreters if you want
				selected_interpreters = {}, -- use default for filetype
				-- Show output even when empty
				show_no_output = { "NvimNotify" },
			})
		end,
		keys = {
			{ "<leader>r", "<Plug>SnipRun", mode = { "n", "v" }, desc = "Run code snippet" },
			{ "<leader>rc", "<Plug>SnipClose", desc = "Close sniprun" },
			{ "<leader>rt", "<Plug>SnipTerminate", desc = "Terminate sniprun" },
		},
	},
	-- Search and replace across project
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- require("config.spectre")
		end,
		keys = {
			{
				"<leader>sr",
				'<cmd>lua require("spectre").toggle()<CR>',
				desc = "Toggle Spectre (Search & Replace)",
			},
			{
				"<leader>sw",
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				desc = "Search current word",
			},
			{
				"<leader>sw",
				'<esc><cmd>lua require("spectre").open_visual()<CR>',
				desc = "Search selected text",
				mode = "v",
			},
			{
				"<leader>sf",
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				desc = "Search in current file",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},

	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	},

	-- ===============================================
	-- BUILD & COMPILATION
	-- ===============================================

	-- {
	-- 	"Zeioth/compiler.nvim",
	-- 	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	-- 	dependencies = { "stevearc/overseer.nvim" },
	-- 	opts = {},
	-- },
	-- {
	-- 	"stevearc/overseer.nvim",
	-- 	commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
	-- 	cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	-- 	opts = {
	-- 		task_list = {
	-- 			direction = "bottom",
	-- 			min_height = 25,
	-- 			max_height = 25,
	-- 			default_detail = 1,
	-- 		},
	-- 	},
	-- },

	-- ===============================================
	-- CODE FORMATTING
	-- ===============================================
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.conform")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			require("config.nvim-lint")
		end,
	},

	-- ===============================================
	-- FILE MANAGEMENT & SEARCH
	-- ===============================================
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	config = function()
	-- 		require("config.nvimtree")
	-- 	end,
	-- },
	-- {
	-- 	"chipsenkbeil/distant.nvim",
	-- 	branch = "v0.3",
	-- 	config = function()
	-- 		require("distant"):setup()
	-- 	end,
	-- },
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("config.oil")
		end,
	},

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
	{ "nvim-tree/nvim-web-devicons" },

	-- Fuzzy finder (FZF instead of Telescope)
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.fzf")
		end,
	},
	-- Telescope (commented out in favor of FZF)
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

	-- ===============================================
	-- GIT INTEGRATION
	-- ===============================================
	-- Modern Git interface
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("neogit").setup({
				graph_style = "kitty", -- Best visuals for Ghostty
				sort_branches = "-committerdate",
				integrations = {
					telescope = false,
					diffview = true,
					fzf_lua = true,
				},
			})
		end,
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
			{ "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit Push" },
			{ "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Neogit Pull" },
		},
	},
	{ "lewis6991/gitsigns.nvim", config = true },
	-- Enhanced git diffs
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		config = function()
			require("diffview").setup({})
		end,
	},
	-- ===============================================
	-- UI ENHANCEMENTS
	-- ===============================================
	-- Start screen
	{
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
	},

	-- Indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},

	-- Terminal integration
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({})
		end,
	},

	-- Enhanced UI messages
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
				stages = "fade",
				timeout = 1500,
				background_colour = "#1E1E2E",
				render = "minimal",
				top_down = false,
			})
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config.lualine")
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("config.bufferline")
		end,
	},

	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		cmd = "Trouble",
	},

	-- Command line enhancements (commented out)
	--{
	--	"gelguy/wilder.nvim",
	--	event = "CmdlineEnter",
	--	config = function()
	--		require("config.wilder")
	--	end,
	--},

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
			require("config.copilot")
		end,
	},

	-- Avante AI chat
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "copilot",
			providers = {
				ollama = {
					endpoint = "http://localhost:11434",
					model = "devstral:24b-small-2505-q4_K_M",
				},
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},

	-- CopilotChat (commented out in favor of Avante)
	--{
	--	"CopilotC-Nvim/CopilotChat.nvim",
	--	dependencies = {
	--		{ "zbirenbaum/copilot.lua" },
	--		{ "nvim-lua/plenary.nvim" },
	--	},
	--	build = "make tiktoken", -- Only on macOS or Linux
	--},

	-- ===============================================
	-- LATEX SUPPORT
	-- ===============================================
	{
		"lervag/vimtex",
		config = function()
			require("config.vimtex")
		end,
	},

	-- ===============================================
	-- MARKDOWN & DOCUMENTATION (COMMENTED OUT)
	-- ===============================================
	-- Markdown preview
	{
		"OXY2DEV/markview.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("config.markview")
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
