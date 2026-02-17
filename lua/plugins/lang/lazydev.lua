return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "mini.nvim", words = { "Mini" } },
			{ path = "snacks.nvim", words = { "Snacks" } },
		},
	},
}
