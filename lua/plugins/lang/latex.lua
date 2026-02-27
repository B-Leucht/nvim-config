-- LaTeX support
return {
	-- {
	-- 	"let-def/texpresso.vim",
	-- 	ft = { "tex", "latex" },
	-- 	keys = {
	-- 		{ "<leader>vx", "<cmd>TeXpresso %<CR>", desc = "Texpresso open", ft = "tex" },
	-- 	},
	-- },
	{
		"lervag/vimtex",
		ft = { "tex", "latex", "bib" },
		keys = {
			{ "<leader>vl", "<cmd>VimtexCompile<CR>",       desc = "VimTeX compile",     ft = "tex" },
			{ "<leader>vv", "<cmd>VimtexView<CR>",          desc = "VimTeX view",        ft = "tex" },
			{ "<leader>vs", "<cmd>VimtexStop<CR>",          desc = "VimTeX stop",        ft = "tex" },
			{ "<leader>vc", "<cmd>VimtexClean<CR>",         desc = "VimTeX clean",       ft = "tex" },
			{ "<leader>vC", "<cmd>VimtexClean!<CR>",        desc = "VimTeX clean all",   ft = "tex" },
			{ "<leader>ve", "<cmd>VimtexErrors<CR>",        desc = "VimTeX errors",      ft = "tex" },
			{ "<leader>vo", "<cmd>VimtexCompileOutput<CR>", desc = "VimTeX output",      ft = "tex" },
			{ "<leader>vg", "<cmd>VimtexStatus<CR>",        desc = "VimTeX status",      ft = "tex" },
			{ "<leader>vG", "<cmd>VimtexStatusAll<CR>",     desc = "VimTeX status all",  ft = "tex" },
			{ "<leader>vt", "<cmd>VimtexTocToggle<CR>",     desc = "VimTeX TOC toggle",  ft = "tex" },
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
