local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("mistweaverco/kulala.nvim") },
	setup = function()
		require("kulala").setup({
			global_keymaps = false,
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
		})

		vim.keymap.set("n", "<leader>Rs", function() require("kulala").run() end, { desc = "Send request" })
		vim.keymap.set("n", "<leader>Ra", function() require("kulala").run_all() end, { desc = "Send all requests" })
		vim.keymap.set("n", "<leader>Rb", function() require("kulala").scratchpad() end, { desc = "Open scratchpad" })
	end,
}
