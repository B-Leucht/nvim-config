-- Mason package manager
return {
	"williamboman/mason.nvim",
	lazy = false,
	priority = 1000,
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			PATH = "prepend",
			ensure_installed = {
				"ltex",
				"pyright",
				"jdtls",
				"texlab",
				"hls",
				"rust_analyzer",
				"lua_ls",
				"markdown-oxide",
				"tinymist",
			},
		})
	end,
}
