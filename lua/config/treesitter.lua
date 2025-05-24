require("nvim-treesitter.configs").setup({
	ensure_installed = { "latex", "nu", "python", "java", "json", "bash", "yaml", "cpp", "haskell", "markdown" },
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = true,
	},
})
