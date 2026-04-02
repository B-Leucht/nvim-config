-- LaTeX support
local gh = require("utils.gh")

return {
	specs = { gh("lervag/vimtex") },
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
	setup = function()
		vim.keymap.set("n", "<leader>vl", "<cmd>VimtexCompile<CR>", { desc = "VimTeX compile" })
		vim.keymap.set("n", "<leader>vv", "<cmd>VimtexView<CR>", { desc = "VimTeX view" })
		vim.keymap.set("n", "<leader>vs", "<cmd>VimtexStop<CR>", { desc = "VimTeX stop" })
		vim.keymap.set("n", "<leader>vc", "<cmd>VimtexClean<CR>", { desc = "VimTeX clean" })
		vim.keymap.set("n", "<leader>vC", "<cmd>VimtexClean!<CR>", { desc = "VimTeX clean all" })
		vim.keymap.set("n", "<leader>ve", "<cmd>VimtexErrors<CR>", { desc = "VimTeX errors" })
		vim.keymap.set("n", "<leader>vo", "<cmd>VimtexCompileOutput<CR>", { desc = "VimTeX output" })
		vim.keymap.set("n", "<leader>vg", "<cmd>VimtexStatus<CR>", { desc = "VimTeX status" })
		vim.keymap.set("n", "<leader>vG", "<cmd>VimtexStatusAll<CR>", { desc = "VimTeX status all" })
		vim.keymap.set("n", "<leader>vt", "<cmd>VimtexTocToggle<CR>", { desc = "VimTeX TOC toggle" })
	end,
}
