-- Snippets
return {
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		ft = { "tex", "latex" },
		config = function()
			require("luasnip-latex-snippets").setup({
				use_treesitter = false,
			})
			require("luasnip").config.setup({ enable_autosnippets = true })
		end,
	},
}