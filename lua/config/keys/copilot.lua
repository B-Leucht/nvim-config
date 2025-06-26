-- Copilot AI assistance keymaps
return {
	{ "<leader>cp", function()
		local copilot_enabled = not vim.g.copilot_enabled
		vim.g.copilot_enabled = copilot_enabled
		vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
		print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
	end, desc = "Toggle Copilot" },
}