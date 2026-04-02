local gh = require("utils.gh")

return {
	specs = { gh("stevearc/conform.nvim") },
	setup = function()
		require("conform").setup({
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
				elixir = { "mix" },
				heex = { "mix" },
				eelixir = { "mix" },
				toml = { "taplo" },
				go = { "goimports", "gofumpt" },
				zig = { "zigfmt" },
			},
			format_after_save = function(bufnr)
				if vim.g.disable_autoformat then
					return
				end
				if vim.b[bufnr].otter_activated or vim.bo[bufnr].buftype == "nofile" then
					return
				end
				return { lsp_format = "fallback" }
			end,
			notify_on_error = true,
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format buffer" })

		vim.keymap.set("n", "<leader>uf", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			local status = vim.g.disable_autoformat and "disabled" or "enabled"
			vim.notify("Format on save " .. status, vim.log.levels.INFO)
		end, { desc = "Toggle format on save" })
	end,
}
