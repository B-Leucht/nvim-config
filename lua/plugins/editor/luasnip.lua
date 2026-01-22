-- LaTeX snippets only (blink.cmp handles general snippets via friendly-snippets)
return {
	"iurimateus/luasnip-latex-snippets.nvim",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			lazy = true,
			config = function()
				require("luasnip").config.setup({ enable_autosnippets = true })
			end,
		},
		"lervag/vimtex",
	},
	ft = { "tex", "latex" },
	config = function()
		require("luasnip-latex-snippets").setup({
			use_treesitter = false,
		})
	end,
}