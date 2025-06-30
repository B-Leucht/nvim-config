-- Git integration plugins
return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
	keys = {
		{ "<leader>gdo", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
		{ "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
		{ "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview file history" },
	},
	opts = {},
}