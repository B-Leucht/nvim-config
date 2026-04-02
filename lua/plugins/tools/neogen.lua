local gh = require("utils.gh")

return {
	specs = { gh("danymat/neogen") },
	setup = function()
		require("neogen").setup({
			snippet_engine = "nvim",
		})
		vim.keymap.set("n", "<leader>cn", function()
			require("neogen").generate()
		end, { desc = "Generate annotation" })
	end,
}
