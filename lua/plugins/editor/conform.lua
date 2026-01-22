-- Code formatting (async)
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
		-- Async formatting after save (non-blocking)
		format_after_save = {
			lsp_fallback = true,
		},
		-- Notify on format errors
		notify_on_error = true,
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer/selection",
		},
		{
			"<leader>cF",
			function()
				require("conform").format({ async = false, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer (sync)",
		},
	},
}
