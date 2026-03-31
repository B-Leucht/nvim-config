local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("saxon1964/neovim-tips") },
	setup = function()
		require("neovim_tips").setup({
			daily_tip = 1,
			bookmark_symbol = "1 ",
		})
		local map = vim.keymap.set
		map("n", "<leader>nto", ":NeovimTips<CR>", { desc = "Neovim tips", silent = true })
		map("n", "<leader>ntb", ":NeovimTipsBookmarks<CR>", { desc = "Bookmarked tips", silent = true })
		map("n", "<leader>nte", ":NeovimTipsEdit<CR>", { desc = "Edit your Neovim tips", silent = true })
		map("n", "<leader>nta", ":NeovimTipsAdd<CR>", { desc = "Add your Neovim tip", silent = true })
		map("n", "<leader>nth", ":help neovim-tips<CR>", { desc = "Neovim tips help", silent = true })
		map("n", "<leader>ntr", ":NeovimTipsRandom<CR>", { desc = "Show random tip", silent = true })
		map("n", "<leader>ntp", ":NeovimTipsPdf<CR>", { desc = "Open Neovim tips PDF", silent = true })
	end,
}
