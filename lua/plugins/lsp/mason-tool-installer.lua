return {
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
				"hlint",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
