-- Code formatting (async)
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	init = function()
		-- Ensure Mason bin is in PATH for formatters
		local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
		if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
			vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
		end
	end,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format" },
			java = { "google-java-format" },
			json = { "jq" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			haskell = { "fourmolu" },
			markdown = { "mdsf" }, --injected
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
