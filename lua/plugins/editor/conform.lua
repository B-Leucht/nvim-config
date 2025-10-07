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
			bzl = { "buildifier" },
			bazel = { "buildifier" },
			bazelrc = { "buildifier" },
			tex = { "latexindent" },
			latex = { "latexindent" },
			bib = { "bibtex-tidy" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 1000,
		},
	},
}
