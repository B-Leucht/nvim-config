-- VimTeX LaTeX support keymaps
return {
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
}