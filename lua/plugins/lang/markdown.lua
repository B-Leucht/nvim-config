-- Markdown support
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = "markdown",
		opts = {
			anti_conceal = {
				enabled = true,
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.conceallevel = 2
					vim.opt_local.concealcursor = "i"
				end,
			})
		end,
	},
}
