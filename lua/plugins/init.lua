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
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
		end,
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
			require("spectre").setup({
				open_cmd = "noswapfile vnew",
				live_update = false,
				line_sep_start = "┌-----------------------------------------",
				result_padding = "¦  ",
				line_sep = "└-----------------------------------------",
				highlight = {
					ui = "String",
					search = "DiffChange",
					replace = "DiffDelete",
				},
				is_insert_mode = true,
				default = {
					replace = {
						cmd = "oxi",
					},
				},
			})
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
		"echasnovski/mini.surround",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
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
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 15,
				max_height = 25,
				default_detail = 1,
				-- Better integration with terminal panel
				bindings = {
					["<C-l>"] = false,
					["<C-h>"] = false,
					["<C-j>"] = false,
					["<C-k>"] = false,
				},
			},
			-- Auto-close when build completes successfully
			task_runner = {
				on_output_parse = true,
			},
			component_aliases = {
				default = {
					{ "display_duration", detail_level = 2 },
					"on_output_summarize",
					"on_exit_set_status",
					{ "on_complete_notify", system = "unfocused" },
				},
			},
		},
	},

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
	-- Telescope (for compiler.nvim)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").setup({})
		end,
	},

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
				-- Always use floating windows for better layout
				kind = "floating",
				popup = {
					kind = "floating",
				},
				integrations = {
					telescope = false,
					diffview = true,
					fzf_lua = true,
				},
			})
		end,
		keys = {
			{ "<leader>gg", "<cmd>Neogit kind=floating <cr>", desc = "Open Neogit" },
			{ "<leader>gc", "<cmd>Neogit kind=floating commit<cr>", desc = "Neogit Commit" },
			{ "<leader>gp", "<cmd>Neogit kind=floating push<cr>", desc = "Neogit Push" },
			{ "<leader>gl", "<cmd>Neogit kind=floating pull<cr>", desc = "Neogit Pull" },
		},
	},
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
			require("toggleterm").setup({
				-- Smart sizing for bottom panel integration
				size = function(term)
					if term.direction == "horizontal" then
						return 20 -- 20% of screen height
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.3
					end
				end,
				open_mapping = [[<C-\>]],
				direction = "horizontal", -- Default to bottom panel
				float_opts = {
					border = "curved",
					width = function()
						return math.floor(vim.o.columns * 0.8)
					end,
					height = function()
						return math.floor(vim.o.lines * 0.8)
					end,
				},
				-- Integrate with compiler panel
				on_create = function()
					vim.opt_local.foldcolumn = "0"
					vim.opt_local.signcolumn = "no"
				end,
			})
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
		"echasnovski/mini.bufremove",
		config = function()
			require("mini.bufremove").setup()
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
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
			require("config.copilot")
		end,
	},

	-- Claude Code TUI integration
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil" },
			},
			-- Diff management
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
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
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
		end,
	},

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
	-- MARKDOWN & DOCUMENTATION
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
