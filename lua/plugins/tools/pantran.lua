-- Translation with pantran.nvim
return {
	"potamides/pantran.nvim",
	cmd = "Pantran",
	keys = {
		{ "<leader>tr", "<cmd>Pantran<cr>", mode = { "n", "v" }, desc = "Translate" },
	},
	opts = {
		default_engine = "google", -- free, no API key needed
		engines = {
			google = {
				default_source = "auto",
				default_target = "de",
			},
			deepl = {
				default_source = "auto",
				default_target = "de",
				-- auth_key = vim.fn.getenv("DEEPL_API_KEY"),
			},
		},
	},
}
