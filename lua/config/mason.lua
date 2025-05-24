require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "ltex", "pyright", "jdtls", "texlab", "hls" },
})
