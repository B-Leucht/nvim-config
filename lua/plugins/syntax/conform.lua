-- Code formatting (async)
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			java = { "google-java-format" },
			json = { "jq" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			haskell = { "fourmolu" },
			markdown = { "injected", "prettier" },
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
			sql = { "sql_formatter" },
			mysql = { "sql_formatter" },
			plsql = { "sql_formatter" },
		},
		format_after_save = function()
			if vim.g.disable_autoformat then
				return
			end
			return { lsp_fallback = true }
		end,
		-- Notify on format errors
		notify_on_error = true,
	},
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({ async = false, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer (sync)",
		},
		{
			"<leader>uf",
			function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				local status = vim.g.disable_autoformat and "disabled" or "enabled"
				vim.notify("Format on save " .. status, vim.log.levels.INFO)
			end,
			desc = "Toggle format on save",
		},
	},
}
