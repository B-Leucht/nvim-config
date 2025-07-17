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

		-- Python LSP
		lspconfig.pyright.setup({
			capabilities = capabilities,
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
