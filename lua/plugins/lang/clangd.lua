local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("p00f/clangd_extensions.nvim") },
	setup = function()
		require("clangd_extensions").setup({})
	end,
}
