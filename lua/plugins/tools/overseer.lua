-- Task runner
return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerRun",
		"OverseerToggle",
		"OverseerOpen",
		"OverseerClose",
		"OverseerTaskAction",
	},
	keys = {
		{ "<leader>Or", "<cmd>OverseerRun<cr>", desc = "Run Task" },
		{ "<leader>Oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
		{ "<leader>Oa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
	},
	opts = {
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
	},
}
