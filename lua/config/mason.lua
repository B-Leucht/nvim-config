require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"ltex",
		"pyright",
		"jdtls",
		"texlab",
		"hls",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		-- ... your existing tools
		-- Linters
		"ruff",
		"shellcheck",
		"luacheck",
		"markdownlint",
		"yamllint",
		"mypy",
		"checkstyle",
	},
})
