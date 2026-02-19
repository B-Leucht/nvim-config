return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		win = {
			border = "rounded",
			wo = {
				winblend = 0,
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader>a", group = "ai" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>d", group = "debug" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "haskell", icon = "󰲒" },
			{ "<leader>j", group = "java", icon = "󰬷" },
			{
				"<leader>l",
				group = "lsp",
				icon = function()
					local icon = MiniIcons.get("filetype", vim.bo.filetype)
					return icon
				end,
			},
			{ "<leader>m", group = "molten", icon = "" },
			{ "<leader>n", group = "notes", icon = "󰎜" },
			{ "<leader>o", group = "obsidian", icon = "󰧑" },
			{ "<leader>p", group = "web", icon = "󰖟" },
			{ "<leader>O", group = "overseer", icon = "" },
			{ "<leader>r", group = "rust", icon = "󱘗" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>T", group = "test" },
			{ "<leader>u", group = "ui" },
			{ "<leader>v", group = "vimtex", icon = "" },
			{ "<leader>w", group = "windows" },
			{ "<leader>x", group = "regex", icon = "󰑑" },
			{ "<leader>c", group = "code", icon = "" },
		})
	end,
}
