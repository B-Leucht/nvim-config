-- AI assistance
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	opts = {
		suggestion = {
			enabled = false, -- Disable inline ghost text suggestions
			auto_trigger = true, -- Trigger automatically if you enable it later
		},
		panel = {
			enabled = true, -- Enable Copilot panel
		},
		filetypes = {
			markdown = true,
		},
	},
	config = function(_, opts)
		require("copilot").setup(opts)
		vim.g.copilot_enabled = true
	end,
}
