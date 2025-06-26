require("catppuccin").setup({
	flavor = "mocha",
	term_colors = true,
	default_integrations = true,
	transparent_background = not vim.g.neovide, -- Disable transparency in Neovide
	integrations = {
		cmp = true,
		fzf = true,
		treesitter = true,
		mason = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

vim.cmd.colorscheme("catppuccin")
