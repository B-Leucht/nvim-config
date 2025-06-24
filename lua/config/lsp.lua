local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.jdtls.setup({ capabilities = capabilities })
lspconfig.ltex.setup({
	capabilities = capabilities,
	settings = {
		ltex = {
			language = "de-DE", -- change as needed
			additionalRules = {
				enablePickyRules = true,
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
