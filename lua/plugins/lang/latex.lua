-- LaTeX support
return {
	{
		"let-def/texpresso.vim",
		ft = { "tex", "latex" },
	},
	{
		"lervag/vimtex",
		ft = { "tex", "latex", "bib" },
		keys = {
			{ "<leader>vtl", "<cmd>VimtexCompile<CR>", desc = "VimTeX compile" },
			{ "<leader>vtv", "<cmd>VimtexView<CR>", desc = "VimTeX view" },
			{ "<leader>vts", "<cmd>VimtexStop<CR>", desc = "VimTeX stop" },
			{ "<leader>vtc", "<cmd>VimtexClean<CR>", desc = "VimTeX clean" },
			{ "<leader>vtC", "<cmd>VimtexClean!<CR>", desc = "VimTeX clean all" },
			{ "<leader>vte", "<cmd>VimtexErrors<CR>", desc = "VimTeX errors" },
			{ "<leader>vto", "<cmd>VimtexCompileOutput<CR>", desc = "VimTeX output" },
			{ "<leader>vtg", "<cmd>VimtexStatus<CR>", desc = "VimTeX status" },
			{ "<leader>vtG", "<cmd>VimtexStatusAll<CR>", desc = "VimTeX status all" },
			{ "<leader>vtt", "<cmd>VimtexTocToggle<CR>", desc = "VimTeX TOC toggle" },
		},
		init = function()
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "sioyek"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.tex_conceal = "abdmg"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				options = { "-pdflua", "-interaction=nonstopmode", "-synctex=1" },
			}

			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				pattern = "*.tex",
				command = "VimtexCompile",
			})
		end,
	},
}
