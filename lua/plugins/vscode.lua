-- ===============================================
-- File: ~/.config/nvim/lua/plugins/vscode.lua
-- ===============================================

-- VS Code specific plugins
return {
	-- ===============================================
	-- NAVIGATION & MOVEMENT
	-- ===============================================
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = false, -- Disable search mode to avoid conflicts with VS Code search
				},
				char = {
					enabled = true,
					jump_labels = true,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},

	-- ===============================================
	-- TEXT MANIPULATION
	-- ===============================================
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- ===============================================
	-- COMMENTS
	-- ===============================================
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
			{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
		},
		config = function()
			require("Comment").setup({
				-- Disable default mappings to avoid conflicts
				mappings = {
					basic = true,
					extra = false,
				},
			})
		end,
	},

	-- ===============================================
	-- INCREMENTAL SELECTION
	-- ===============================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Only enable what's useful in VS Code
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},

	-- ===============================================
	-- TEXT OBJECTS
	-- ===============================================
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- ===============================================
	-- WHICH-KEY (HELPFUL FOR KEYBINDING DISCOVERY)
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
}
