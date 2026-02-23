-- Core LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"folke/lazydev.nvim",
	},
	config = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})


		-- Ensure Mason path is set (cross-platform)
		local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
		local path_separator = vim.fn.has("win32") == 1 and ";" or ":"
		if not string.find(vim.env.PATH, mason_path, 1, true) then
			vim.env.PATH = mason_path .. path_separator .. vim.env.PATH
		end

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					workspace = {
						library = { vim.env.VIMRUNTIME .. "/lua" },
						checkThirdParty = false,
					},
				},
			},
		})

		vim.lsp.enable("pyright", false)

		vim.lsp.config("basedpyright", {
			before_init = function(_, config)
				local venv = vim.fn.getcwd() .. "/.venv"
				if vim.fn.isdirectory(venv) == 1 then
					config.settings.python = config.settings.python or {}
					config.settings.python.pythonPath = venv .. "/bin/python"
				end
			end,
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "basic", -- "off", "basic", "standard", "strict", "all"
						diagnosticSeverityOverrides = {
							reportUnusedImport = "information",
							reportUnusedVariable = "information",
							reportMissingTypeStubs = false,
						},
					},
				},
				python = {
					analysis = {
						inlayHints = {
							variableTypes = true,
							functionReturnTypes = true,
						},
					},
				},
			},
		})

		vim.lsp.config("markdown_oxide", {
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
		})

		vim.lsp.config("tailwindcss", {
			filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
		})

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		})

		vim.lsp.config("tinymist", {
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onType",
				semanticTokens = "disable",
			},
		})

		vim.lsp.config("ltex_plus", {
			cmd = { "ltex-ls-plus" },
			filetypes = { "markdown", "text", "latex", "tex", "bib", "typst" },
			settings = {
				ltex = {
					language = "auto",
					completionEnabled = false,
					additionalRules = {
						enablePickyRules = false,
						motherTongue = "de",
						languageModel = vim.fn.expand("~/ngrams"),
					},
					checkFrequency = "edit",
				},
			},
		})

		vim.lsp.config("texlab", {
			settings = {
				texlab = {
					build = {
						executable = "latexmk",
						args = { "-pdflua", "-interaction=nonstopmode", "-synctex=1", "%f" },
						onSave = false,
					},
					forwardSearch = {
						executable = "sioyek",
						args = { "--reuse-window", "--forward-search-file", "%f", "--forward-search-line", "%l", "%p" },
					},
					chktex = { onOpenAndSave = true },
				},
			},
		})


		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end
				if client.server_capabilities.inlayHintProvider and client.name ~= "haskell-tools.nvim" then
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
				end
				if client.server_capabilities.codeLensProvider then
					vim.lsp.codelens.refresh({ bufnr = args.buf })
					vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
						buffer = args.buf,
						callback = function()
							vim.lsp.codelens.refresh({ bufnr = args.buf })
						end,
					})
				end
			end,
		})
	end,
}
