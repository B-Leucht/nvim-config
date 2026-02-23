return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "mini.nvim", words = { "Mini" } },
			{ path = "snacks.nvim", words = { "Snacks" } },
			{ path = "lazy.nvim", words = { "Lazy" } },
			{ path = "neotest", words = { "neotest" } },
			{ path = "nvim-dap", words = { "dap" } },
			{ path = "overseer.nvim", words = { "overseer" } },
			{ path = "which-key.nvim", words = { "which%-key", "wk" } },
			{ path = "noice.nvim", words = { "noice" } },
			{ path = "lualine.nvim", words = { "lualine" } },
			{ path = "flash.nvim", words = { "flash" } },
			{ path = "conform.nvim", words = { "conform" } },
			{ path = "nvim-lint", words = { "lint" } },
			{ path = "nvim-treesitter", words = { "treesitter" } },
			{ path = "blink.cmp", words = { "blink" } },
			{ path = "obsidian.nvim", words = { "obsidian" } },
			{ path = "markview.nvim", words = { "markview" } },
			{ path = "incline.nvim", words = { "incline" } },
			{ path = "flatten.nvim", words = { "flatten" } },
			{ path = "haskell-tools.nvim", words = { "haskell%-tools" } },
			{ path = "rustaceanvim", words = { "rustaceanvim" } },
		},
	},
}
