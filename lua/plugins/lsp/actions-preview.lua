local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("aznhe21/actions-preview.nvim") },
	setup = function()
		require("actions-preview").setup({
			backend = { "snacks" },
		})
	end,
}
