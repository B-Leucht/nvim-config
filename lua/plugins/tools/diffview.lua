local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("sindrets/diffview.nvim") },
	setup = function()
		require("diffview").setup({})
		vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Diffview Open" })
		vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History (current)" })
		vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "File History (repo)" })
	end,
}
