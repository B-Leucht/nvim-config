return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "folke/snacks.nvim" },
	ft = "python",
	keys = {
		{ "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" },
	},
	opts = {},
}
