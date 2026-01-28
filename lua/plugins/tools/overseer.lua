-- Task runner
return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerRun",
		"OverseerToggle",
		"OverseerOpen",
		"OverseerClose",
		"OverseerBuild",
		"OverseerTaskAction",
	},
	keys = {
		{ "<leader>Oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
		{ "<leader>Or", "<cmd>OverseerRun<cr>", desc = "Run Task" },
		{ "<leader>Ob", "<cmd>OverseerBuild<cr>", desc = "Build" },
		{ "<leader>Oa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
		{ "<leader>Oq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
		{ "<leader>Ol", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
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
