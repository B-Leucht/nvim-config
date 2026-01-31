-- Mason package manager
-- Non-LSP tools (install manually via :Mason):
-- Formatters: stylua, google-java-format, jq, clang-format, fourmolu, prettier, latexindent, bibtex-tidy, mdsf, sql-formatter
-- Linters: ruff, shellcheck, luacheck, markdownlint, yamllint, checkstyle, hlint, cpplint, vale, sqlfluff, alex
-- Debuggers: codelldb, java-debug-adapter, java-test

return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = true,
			ensure_installed = {
				"basedpyright",
				"bashls",
				"clangd",
				"cssls",
				"docker_compose_language_service",
				"dockerls",
				"gradle_ls",
				"html",
				"ltex_plus",
				"lua_ls",
				"markdown_oxide",
				"sqlls",
				"texlab",
				"tinymist",
				"ts_ls",
			},
		},
	},
}
