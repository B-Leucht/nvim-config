return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },
	lazy = false,
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"jdtls",
				"texlab",
				"ltex",
				"hls",
				"rust_analyzer",
			},
			automatic_installation = true,
		})
	end,
}
