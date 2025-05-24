-- Setup for copilot.lua
require("copilot").setup({
	suggestion = {
		enabled = false, -- Disable inline ghost text suggestions
		auto_trigger = true, -- Trigger automatically if you enable it later
	},
	panel = {
		enabled = true, -- Enable Copilot panel
	},
})

-- Setup for copilot-cmp
require("copilot_cmp").setup()
