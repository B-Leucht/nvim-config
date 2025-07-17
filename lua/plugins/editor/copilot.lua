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
	},
	keys = {
		-- {
		-- 	"<leader>cp",
		-- 	function()
		-- 		local copilot_enabled = not vim.g.copilot_enabled
		-- 		vim.g.copilot_enabled = copilot_enabled
		-- 		vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
		-- 		print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
		-- 	end,
		-- 	desc = "Toggle Copilot",
		-- },
	},
}
