local gh = require("utils.gh")

return {
	specs = { gh("stevearc/quicker.nvim") },
	setup = function()
		require("quicker").setup({})
	end,
}
