-- Syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		ensure_installed = {
			"latex",
			"nu",
			"python",
			"java",
			"json",
			"bash",
			"yaml",
			"cpp",
			"haskell",
			"markdown",
			"rust",
			"toml",
		},
		auto_install = true,
		sync_install = false,
		highlight = {
			enable = true,
		},
	},
}