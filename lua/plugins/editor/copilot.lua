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
	config = function(_, opts)
		require("copilot").setup(opts)
		-- Disable copilot by default and for exam mode
		vim.cmd("Copilot disable")
		vim.g.copilot_enabled = false
		
		-- Exam mode function
		_G.enable_exam_mode = function()
			vim.cmd("Copilot disable")
			vim.g.copilot_enabled = false
			vim.notify("EXAM MODE: All AI tools disabled", vim.log.levels.WARN)
		end
	end,
	keys = {
		{
			"<leader>cp",
			function()
				local copilot_enabled = not vim.g.copilot_enabled
				vim.g.copilot_enabled = copilot_enabled
				vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
				vim.notify("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
			end,
			desc = "Toggle Copilot",
		},
	},
}
