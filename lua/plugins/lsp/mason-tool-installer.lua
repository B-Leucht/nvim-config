return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP servers
				"ltex-ls",
				"pyright",
				"jdtls",
				"java-test",
				"java-debug-adapter",
				"texlab",
				"lua-language-server",
				"markdown-oxide",
				"tinymist",
				"clangd",
				"bash-language-server",
				"dockerfile-language-server",
				"docker-compose-language-service",
				"gradle-language-server",
				"typescript-language-server",
				"css-lsp",
				"html-lsp",
				-- Formatters
				"stylua",
				"black",
				"google-java-format",
				"jq",
				"clang-format",
				"fourmolu",
				"prettier",
				"latexindent",
				"bibtex-tidy",
				-- Linters
				"ruff",
				"shellcheck",
				"luacheck",
				"markdownlint",
				"yamllint",
				"checkstyle",
				"hlint",
				"cpplint",
				-- Debuggers
				"codelldb",
				-- "java-debug-adapter",
				-- "java-test",
			},
			auto_update = false,
			run_on_start = true,
		})
	end,
}
