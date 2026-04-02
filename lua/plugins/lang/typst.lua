local gh = require("utils.gh")

return {
	specs = { gh("chomosuke/typst-preview.nvim") },
	setup = function()
		require("typst-preview").setup({})
	end,
}
