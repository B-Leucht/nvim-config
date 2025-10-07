-- Mason package manager
return {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			PATH = "prepend",
		})
	end,
}
