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
			},
		})
	end,
},
{
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
},
{
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	lazy = false,
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"stylua",
				"black",
				"google-java-format",
				"jq",
				"clang-format",
				"fourmolu",
				"prettier",
				-- Linters
				"ruff",
				"shellcheck",
				"luacheck",
				"markdownlint",
				"yamllint",
				"mypy",
				"checkstyle",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}