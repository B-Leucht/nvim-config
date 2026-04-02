local gh = require("utils.gh")

return {
	specs = { gh("OXY2DEV/patterns.nvim") },
	setup = function()
		vim.keymap.set("n", "<leader>xp", "<cmd>Patterns hover<cr>", { desc = "Explain Pattern" })
		vim.keymap.set("n", "<leader>xP", "<cmd>Patterns explain<cr>", { desc = "Pattern Editor" })
	end,
}
