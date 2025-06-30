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
			python = { "ruff", "mypy" },

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
			c = { "cppcheck" },
			cpp = { "cppcheck" },
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

		-- Auto-lint on certain events
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Only lint if the buffer is attached to a file
				if vim.api.nvim_buf_get_name(0) ~= "" then
					lint.try_lint()
				end
			end,
		})

		-- Manual linting command
		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
		end,

}