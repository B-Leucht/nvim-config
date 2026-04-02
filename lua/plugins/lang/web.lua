local gh = require("utils.gh")

return {
	specs = {
		gh("brenoprata10/nvim-highlight-colors"),
		gh("vuki656/package-info.nvim"),
		gh("MunifTanjim/nui.nvim"),
	},
	setup = function()
		require("nvim-highlight-colors").setup({})
		require("package-info").setup({})

		vim.keymap.set("n", "<leader>ps", function() require("package-info").show() end, { desc = "Show Package Info" })
		vim.keymap.set("n", "<leader>ph", function() require("package-info").hide() end, { desc = "Hide Package Info" })
		vim.keymap.set("n", "<leader>pu", function() require("package-info").update() end, { desc = "Update Package" })
		vim.keymap.set("n", "<leader>pd", function() require("package-info").delete() end, { desc = "Delete Package" })
		vim.keymap.set("n", "<leader>pi", function() require("package-info").install() end, { desc = "Install Package" })
		vim.keymap.set("n", "<leader>pc", function() require("package-info").change_version() end, { desc = "Change Version" })
	end,
}
