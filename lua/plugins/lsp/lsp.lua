-- Core LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Ensure Mason path is set (cross-platform)
		local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
		local path_separator = vim.fn.has("win32") == 1 and ";" or ":"
		if not string.find(vim.env.PATH, mason_path, 1, true) then
			vim.env.PATH = mason_path .. path_separator .. vim.env.PATH
		end

		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = {
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
		vim.lsp.enable("pyright")

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

		-- jdtls is handled by nvim-jdtls plugin, not lspconfig
		-- Function to switch ltex language
		local function switch_ltex_language()
			local current_clients = vim.lsp.get_clients({ name = "ltex" })
			if #current_clients == 0 then
				vim.notify("LTeX server not running", vim.log.levels.WARN)
				return
			end

			local current_lang = current_clients[1].config.settings.ltex.language
			local new_lang = current_lang == "en-US" and "de-DE" or "en-US"

			-- Update settings for all ltex clients
			for _, client in pairs(current_clients) do
				client.config.settings.ltex.language = new_lang
				client.notify("workspace/didChangeConfiguration", {
					settings = client.config.settings,
				})
			end

			vim.notify("LTeX language switched to " .. new_lang, vim.log.levels.INFO)
		end

		-- Make function globally accessible
		_G.switch_ltex_language = switch_ltex_language

		vim.lsp.config("ltex", {
			capabilities = capabilities,
			settings = {
				ltex = {
					language = "de-DE", -- default to German
					additionalRules = {
						enablePickyRules = true,
						-- languageModel = "~/models/ngrams/",
					},
					dictionary = {
						-- custom words, optional
						["en-US"] = { "Neovim", "Lua", "LSP" },
						["de-DE"] = { "Neovim", "Lua", "LSP" },
					},
					disabledRules = {},
					trace = { server = "verbose" }, -- optional for debugging
				},
			},
			on_attach = function(client, bufnr)
				-- You can add your on_attach logic here
			end,
		})
		vim.lsp.enable("ltex")

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
