local gh = require("utils.gh")

return {
	specs = { gh("p00f/clangd_extensions.nvim") },
	setup = function()
		require("clangd_extensions").setup({})
	end,
}
