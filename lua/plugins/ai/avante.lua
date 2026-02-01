return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = "make",
	opts = {
		provider = "copilot",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				auth_type = "max",
				timeout = 30000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 4096,
				},
			},
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "gpt-4o",
				timeout = 30000,
				extra_request_body = {
					temperature = 0.7,
					max_tokens = 8192,
				},
			},
			ollama = {
				endpoint = "http://127.0.0.1:11434",
				model = "qwen2.5-coder:14b",
				timeout = 60000,
				extra_request_body = {
					temperature = 0.7,
				},
			},
		},
	},
	keys = {
		{ "<leader>az", function() require("avante.api").zen_mode() end, desc = "Avante Zen Mode" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.icons",
		"zbirenbaum/copilot.lua",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
