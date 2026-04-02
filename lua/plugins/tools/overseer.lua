local gh = require("utils.gh")

return {
	specs = { gh("stevearc/overseer.nvim") },
	setup = function()
		require("overseer").setup({
			strategy = "terminal",
			templates = { "builtin" },
			task_list = {
				direction = "bottom",
				min_height = 15,
				max_height = 25,
				default_detail = 1,
				bindings = {
					["q"] = "Close",
					["<C-c>"] = "Stop",
					["r"] = "Restart",
					["<CR>"] = "RunAction",
				},
			},
			form = {
				border = "rounded",
				win_opts = { winblend = 0 },
			},
			confirm = {
				border = "rounded",
				win_opts = { winblend = 0 },
			},
			task_win = {
				border = "rounded",
				win_opts = { winblend = 0 },
			},
		})

		vim.keymap.set("n", "<leader>Or", "<cmd>OverseerRun<cr>", { desc = "Run Task" })
		vim.keymap.set("n", "<leader>Oo", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer" })
		vim.keymap.set("n", "<leader>Oa", "<cmd>OverseerTaskAction<cr>", { desc = "Task Action" })
	end,
}
