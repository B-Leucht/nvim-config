require("catppuccin").setup({
	pflavour = "mocha",
	default_integrations = true,
	transparent_background = true,
	integrations = {
		cmp = true,
		fzf = true,
		nvimtree = true,
		treesitter = true,
		mason = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

vim.cmd.colorscheme("catppuccin")
