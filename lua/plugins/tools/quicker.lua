local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("stevearc/quicker.nvim") },
	setup = function()
		require("quicker").setup({})
	end,
}
