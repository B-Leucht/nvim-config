-- Linting (only for things LSP doesn't cover)
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- Web (eslint for style rules ts_ls doesn't catch)
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			vue = { "eslint_d" },

			-- Shell (bashls is limited)
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },

			-- Markup
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
			json = { "jsonlint" },

			-- Docker
			dockerfile = { "hadolint" },

			-- CSS
			css = { "stylelint" },
			scss = { "stylelint" },

			-- Java
			java = { "checkstyle" },

			-- LaTeX
			tex = { "chktex" },
			latex = { "chktex" },

			-- SQL
			sql = { "sqlfluff" },
		}

		-- Configure checkstyle for Java
		lint.linters.checkstyle.args = {
			"-c",
			"/google_checks.xml",
			"-f",
			"sarif",
		}

		-- Configure chktex for LaTeX
		lint.linters.chktex.args = {
			"-n22",
			"-n30",
			"-e16",
			"-q",
		}
		lint.linters.chktex.ignore_exitcode = true

		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })

		vim.keymap.set("n", "<leader>cL", function()
			vim.diagnostic.reset(nil, 0)
		end, { desc = "Clear linting diagnostics" })
	end,
}
