local gh = require("utils.gh")

return {
	specs = { gh("mbbill/undotree") },
	setup = function()
		vim.keymap.set("n", "<leader>uu", "<cmd>UndotreeToggle<cr>", { desc = "Undotree" })
	end,
}
