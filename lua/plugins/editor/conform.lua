-- Code formatting
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			java = { "google-java-format" },
			json = { "jq" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			haskell = { "fourmolu" },
			markdown = { "prettier" },
			tex = { "latexindent" },
			latex = { "latexindent" },
			bib = { "bibtex-tidy" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 3000,
		},
	},
}
