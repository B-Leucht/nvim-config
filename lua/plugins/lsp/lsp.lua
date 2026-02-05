-- Core LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
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

		vim.lsp.config("basedpyright", {
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

		vim.lsp.enable("hls")

		vim.lsp.config("markdown_oxide", {
			capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities(), {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
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

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

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
					completionEnabled = false, -- Disabled - prefer dictionary completions
					additionalRules = {
						enablePickyRules = false,
						motherTongue = "de",
						languageModel = vim.fn.expand("~/ngrams"),
					},
					checkFrequency = "edit",
				},
			},
		})

		-- Enable inlay hints globally for all LSP servers that support it
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
				end
			end,
		})
	end,
}
