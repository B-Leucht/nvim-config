local parsers = {
	"latex",
	"nu",
	"python",
	"java",
	"json",
	"bash",
	"yaml",
	"cpp",
	"c",
	"haskell",
	"markdown",
	"markdown_inline",
	"rust",
	"toml",
	"lua",
	"vim",
	"vimdoc",
	"html",
	"css",
	"javascript",
	"typescript",
	"tsx",
	"scss",
	"svelte",
	"typst",
	"vue",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ts = require("nvim-treesitter")
			-- Install markdown parsers
			ts.install({ "markdown", "markdown_inline" })
			-- Create command to install all parsers
			vim.api.nvim_create_user_command("TSInstallAll", function()
				ts.install(parsers)
			end, { desc = "Install all configured treesitter parsers" })
		end,
	},
	-- Sticky context at top of buffer
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = {
			max_lines = 3,
			min_window_height = 20,
			multiline_threshold = 1,
		},
		keys = {
			{
				"<leader>uc",
				function()
					require("treesitter-context").toggle()
				end,
				desc = "Toggle Treesitter Context",
			},
		},
	},
	-- Better comment strings per language context
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
