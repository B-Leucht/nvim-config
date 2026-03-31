local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("m4xshen/hardtime.nvim") },
	setup = function()
		require("hardtime").setup({
			disable_mouse = false,
		})
		vim.keymap.set("n", "<leader>uH", "<cmd>Hardtime toggle<cr>", { desc = "Toggle Hardtime" })
	end,
}
