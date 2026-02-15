-- AI assistance (load only when needed)
return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	cmd = "Copilot",
	build = ":Copilot auth",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = true },
		filetypes = { markdown = true },
	},
}
