require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"ltex",
		"pyright",
		"jdtls",
		"texlab",
		"hls",
		"rust_analyzer",
	},
})

-- require("mason-tool-installer").setup({
-- 	ensure_installed = {
-- 		-- ... your existing tools
-- 		-- Linters
-- 		"ruff",
-- 		"shellcheck",
-- 		"luacheck",
-- 		"markdownlint",
-- 		"yamllint",
-- 		"mypy",
-- 		"checkstyle",
-- 	},
-- })
