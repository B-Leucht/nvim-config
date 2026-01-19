-- Linting
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- lua/config/nvim-lint.lua
		local lint = require("lint")

		-- Configure linters by filetype
		lint.linters_by_ft = {
			-- Web Development
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			vue = { "eslint_d" },

			-- Python
			python = { "ruff" },

			-- Shell
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },

			-- Lua
			lua = { "luacheck" },

			-- Markdown
			markdown = { "markdownlint" },

			-- YAML
			yaml = { "yamllint" },

			-- JSON
			json = { "jsonlint" },

			-- Docker
			dockerfile = { "hadolint" },

			-- CSS
			css = { "stylelint" },
			scss = { "stylelint" },

			-- Go
			go = { "golangcilint" },

			-- Rust
			rust = { "clippy" },

			-- PHP
			php = { "phpstan" },

			-- Java
			java = { "checkstyle" },

			-- C/C++
			c = { "cpplint" },
			cpp = { "cpplint" },

			-- Haskell
			haskell = { "hlint" },

			-- LaTeX
			tex = { "chktex" },
			latex = { "chktex" },
		}

		-- Configure specific linters if needed
		lint.linters.luacheck.args = {
			"--globals",
			"vim",
			"--formatter",
			"plain",
			"--codes",
			"--ranges",
			"-",
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

	
		-- Manual linting command
		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
