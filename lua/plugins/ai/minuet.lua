return {
	"milanglacier/minuet-ai.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "InsertEnter",
	keys = {
		{ "<leader>am", "<cmd>Minuet blink toggle<CR>", desc = "Toggle Minuet AI source" },
	},
	opts = {
		provider = "openai_fim_compatible",
		n_completions = 1,
		context_window = 512,
		virtualtext = {
			auto_trigger_ft = {},
			keymap = {
				accept = "<Tab>",
				accept_line = "<S-Tab>",
				next = "<C-n>",
				prev = "<C-p>",
				dismiss = "<C-e>",
			},
		},
		provider_options = {
			openai_fim_compatible = {
				api_key = "TERM",
				name = "Ollama",
				end_point = "http://localhost:11434/v1/completions",
				model = "qwen2.5-coder:14b",
				optional = {
					max_tokens = 56,
					top_p = 0.9,
				},
			},
		},
	},
}
