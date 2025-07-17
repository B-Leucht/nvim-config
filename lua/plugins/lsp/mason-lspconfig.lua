return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },
	lazy = false,
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
			},
			automatic_installation = true,
		})
	end,
}
