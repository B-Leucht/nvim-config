-- Core LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Ensure Mason path is set (cross-platform)
		local mason_path = vim.fn.stdpath("data") .. "/mason/bin"
		local path_separator = vim.fn.has("win32") == 1 and ";" or ":"
		if not string.find(vim.env.PATH, mason_path, 1, true) then
			vim.env.PATH = mason_path .. path_separator .. vim.env.PATH
		end

		lspconfig.pyright.setup({
			capabilities = capabilities,
		})

		lspconfig.hls.setup({
			capabilities = capabilities,
			cmd = { "haskell-language-server-wrapper", "--lsp" },
			settings = {
				haskell = {
					formattingProvider = "fourmolu",
				},
			},
			filetypes = { "haskell", "lhaskell" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "hie.yaml")(fname)
					or lspconfig.util.find_git_ancestor(fname)
					or vim.fn.getcwd()
			end,
		})

		lspconfig.jdtls.setup({
			capabilities = capabilities,
		})
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

		lspconfig.ltex.setup({
			capabilities = capabilities,
			settings = {
				ltex = {
					language = "en-US", -- default to English
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
		lspconfig.texlab.setup({
			capabilities = capabilities,
		})

		require("lspconfig").markdown_oxide.setup({
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

		lspconfig.rust_analyzer.setup({
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

		lspconfig.tinymist.setup({
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onType",
				semanticTokens = "disable",
			},
		})
		lspconfig.lua_ls.setup({
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
				},
			},
		})
	end,
}
