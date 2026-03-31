local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("mfussenegger/nvim-lint") },
	setup = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			vue = { "eslint_d" },

			python = { "ruff" },

			sh = { "shellcheck" },
			bash = { "shellcheck" },

			dockerfile = { "hadolint" },

			css = { "stylelint" },
			scss = { "stylelint" },

			java = { "checkstyle" },

			sql = { "sqlfluff" },

			elixir = { "credo" },

			go = { "golangcilint" },
		}

		-- Configure checkstyle for Java
		lint.linters.checkstyle.args = {
			"-c",
			"/google_checks.xml",
			"-f",
			"sarif",
		}

		-- Only run eslint_d when an ESLint config exists in the project
		local eslint_config_files = {
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			".eslintrc.yml",
			".eslintrc.yaml",
		}

		local function has_eslint_config()
			for _, file in ipairs(eslint_config_files) do
				if vim.fn.findfile(file, ".;") ~= "" then
					return true
				end
			end
			return false
		end

		local function try_lint()
			local ft = vim.bo.filetype
			local linters = lint.linters_by_ft[ft] or {}
			local filtered = vim.tbl_filter(function(name)
				if name == "eslint_d" then
					return has_eslint_config()
				end
				return true
			end, linters)
			lint.try_lint(filtered)
		end

		vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged" }, {
			callback = try_lint,
		})

		vim.keymap.set("n", "<leader>cl", try_lint, { desc = "Trigger linting for current file" })

		vim.keymap.set("n", "<leader>cL", function()
			vim.diagnostic.reset(nil, 0)
		end, { desc = "Clear linting diagnostics" })
	end,
}
