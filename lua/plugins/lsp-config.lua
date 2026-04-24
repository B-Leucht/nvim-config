local gh = require("utils.gh")

return {
	specs = {
		gh("neovim/nvim-lspconfig"),
		gh("b0o/schemastore.nvim"),
	},
	setup = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.enable({
			"basedpyright",
			"ruff",
			"bashls",
			"clangd",
			"cssls",
			"docker_compose_language_service",
			"dockerls",
			"gradle_ls",
			"gopls",
			"html",
			"jsonls",
			"lua_ls",
			"markdown_oxide",
			"sqlls",
			"texlab",
			"tinymist",
			"tailwindcss",
			"ltex_plus",
			"phpactor",
			"emmet_language_server",
			"taplo",
			"ts_ls",
			"yamlls",
			"zls",
		})

		-- Re-trigger FileType after startup so LSPs attach to the initial buffer
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_loaded(buf) then
						local ft = vim.bo[buf].filetype
						if ft and ft ~= "" then
							vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
						end
					end
				end
			end,
		})

		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					typeCheckingMode = "standard",
				},
			},
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
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		})

		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		vim.lsp.config("yamlls", {
			settings = {
				yaml = {
					schemaStore = { enable = false, url = "" },
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					gofumpt = true,
					staticcheck = true,
					analyses = {
						unusedparams = true,
						shadow = true,
						nilness = true,
						unusedwrite = true,
						useany = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
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
						enablePickyRules = true,
						motherTongue = "de",
						languageModel = vim.fn.expand("~/ngrams"),
					},
					checkFrequency = "edit",
				},
			},
		})

		Snacks.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, {
			lsp = { method = "textDocument/codeAction" },
			desc = "Code actions",
		})
		Snacks.keymap.set("n", "K", vim.lsp.buf.hover, {
			lsp = { method = "textDocument/hover" },
			desc = "Hover documentation",
		})
		Snacks.keymap.set("n", "<leader>lc", vim.lsp.codelens.run, {
			lsp = { method = "textDocument/codeLens" },
			desc = "Run codelens",
		})
		Snacks.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {
			lsp = { method = "textDocument/rename" },
			desc = "Rename",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				vim.keymap.set(
					"n",
					"<leader>cd",
					vim.diagnostic.open_float,
					{ buffer = args.buf, desc = "Line diagnostics (float)" }
				)

				if client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					vim.keymap.set("n", "<leader>lh", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, { buffer = args.buf, desc = "Toggle inlay hints" })

					vim.keymap.set("n", "<leader>li", function()
						require("inlayhint-filler").fill()
					end, { buffer = args.buf, desc = "Insert inlay hint" })
				end

				if client.server_capabilities.codeLensProvider then
					vim.lsp.codelens.enable(true, { bufnr = args.buf })
					vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
						buffer = args.buf,
						callback = function()
							vim.lsp.codelens.enable(true, { bufnr = args.buf })
						end,
					})
				end
			end,
		})
	end,
}
