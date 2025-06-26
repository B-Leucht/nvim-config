-- Setup mason-lspconfig
return {
	ensure_installed = {
		"ltex",
		"pyright",
		"jdtls",
		"texlab",
		"hls",
		"rust_analyzer",
		"lua_ls",
	},
}
