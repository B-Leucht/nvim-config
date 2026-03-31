return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	keys = {
		{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
		{ "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline Prompt" },
	},
	opts = {
		strategies = {
			chat = { adapter = "anthropic" },
			inline = { adapter = "anthropic" },
		},
		adapters = {
			anthropic = function()
				return require("codecompanion.adapters").extend("anthropic", {
					schema = {
						model = { default = "claude-sonnet-4-20250514" },
					},
				})
			end,
		},
	},
}
