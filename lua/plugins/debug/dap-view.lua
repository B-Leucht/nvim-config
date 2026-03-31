local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("igorlfs/nvim-dap-view") },
	setup = function()
		require("dap-view").setup({
			winbar = {
				controls = {
					enabled = true,
				},
			},
		})

		vim.keymap.set("n", "<leader>du", "<cmd>DapViewToggle<cr>", { desc = "Toggle DAP-View" })
	end,
}
