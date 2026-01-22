-- Syntax highlighting with nvim-treesitter (new API - v1.0+)
local parsers = {
	"latex", "nu", "python", "java", "json", "bash", "yaml", "cpp", "c",
	"haskell", "markdown", "markdown_inline", "rust", "toml", "lua",
	"vim", "vimdoc", "html", "css", "javascript", "typescript", "tsx",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		lazy = vim.fn.argc(-1) == 0,
		config = function()
			-- Create command to install all parsers (run manually when needed)
			vim.api.nvim_create_user_command("TSInstallAll", function()
				for _, parser in ipairs(parsers) do
					vim.cmd("TSInstall! " .. parser)
				end
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
