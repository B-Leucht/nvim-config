-- LSP and Language Server support plugins
return {
	"onsails/lspkind.nvim",
	lazy = true,
},

-- Lua development
{
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}