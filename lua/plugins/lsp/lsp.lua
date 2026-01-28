-- Core LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Ensure Mason path is set (cross-platform)
		local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
		local path_separator = vim.fn.has("win32") == 1 and ";" or ":"
		if not string.find(vim.env.PATH, mason_path, 1, true) then
			vim.env.PATH = mason_path .. path_separator .. vim.env.PATH
		end

		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "standard", -- "off", "basic", "standard", "strict", "all"
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
		vim.lsp.enable("basedpyright")

		vim.lsp.config("hls", {
			capabilities = capabilities,
			cmd = { "haskell-language-server-wrapper", "--lsp" },
			settings = {
				haskell = {
					formattingProvider = "fourmolu",
				},
			},
			filetypes = { "haskell", "lhaskell" },
			root_markers = { "*.cabal", "stack.yaml", "cabal.project", "hie.yaml", ".git" },
		})
		vim.lsp.enable("hls")

		vim.lsp.config("texlab", {
			capabilities = capabilities,
		})
		vim.lsp.enable("texlab")

		vim.lsp.config("markdown_oxide", {
			-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
			-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
			-- on_attach = on_attach, -- configure your on attach config
		})
		vim.lsp.enable("markdown_oxide")

		vim.lsp.config("clangd", {
			capabilities = capabilities,
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
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		})
		vim.lsp.enable("clangd")

		vim.lsp.config("bashls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("bashls")

		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
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
		vim.lsp.enable("tinymist")

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
					hint = {
						enable = false, -- Disable all lua_ls inlay hints (too noisy)
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("dockerls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("dockerls")

		vim.lsp.config("docker_compose_language_service", {
			capabilities = capabilities,
			filetypes = { "yaml.docker-compose", "yaml" },
			root_markers = {
				"docker-compose.yml",
				"docker-compose.yaml",
				"compose.yml",
				"compose.yaml",
			},
		})
		vim.lsp.enable("docker_compose_language_service")

		vim.lsp.config("gradle_ls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("gradle_ls")

		vim.lsp.enable("alex")

		-- vim.lsp.enable("codebook")

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
					},
				},
			},
		})
		vim.lsp.enable("ts_ls")

		vim.lsp.config("cssls", {
			capabilities = capabilities,
			filetypes = { "css", "scss", "less" },
		})
		vim.lsp.enable("cssls")

		vim.lsp.config("html", {
			capabilities = capabilities,
			filetypes = { "html", "templ" },
		})
		vim.lsp.enable("html")

		-- vim.lsp.config("harper_ls", {
		-- 	capabilities = capabilities,
		-- 	settings = {
		-- 		["harper-ls"] = {
		-- 			linters = {
		-- 				SentenceCapitalization = false,
		-- 				SpellCheck = false,
		-- 			},
		-- 		},
		-- 	},
		-- })
		-- vim.lsp.enable("harper_ls")

		vim.lsp.config("ltex_plus", {
			cmd = { "ltex-ls-plus" },
			capabilities = capabilities,
			filetypes = { "markdown", "text", "latex", "tex", "bib", "typst" },
			settings = {
				ltex = {
					language = "auto",
					completionEnabled = false, -- Disabled - prefer dictionary completions
					additionalRules = {
						enablePickyRules = true,
						motherTongue = "de",
						languageModel = vim.fn.expand("~/ngrams"),
					},
					checkFrequency = "edit",
				},
			},
		})
		vim.lsp.enable("ltex_plus")

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
