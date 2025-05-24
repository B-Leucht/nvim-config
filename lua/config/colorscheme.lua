vim.cmd.colorscheme("catppuccin-mocha")
require("catppuccin").setup({
	default_integrations = true,
	integrations = { cmp = true, fzf = true, nvimtree = true, treesitter = true, mason = true },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
