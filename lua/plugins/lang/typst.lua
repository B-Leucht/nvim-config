local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("chomosuke/typst-preview.nvim") },
	setup = function()
		require("typst-preview").setup({})
	end,
}
