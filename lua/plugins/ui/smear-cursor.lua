local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("sphamba/smear-cursor.nvim") },
	setup = function()
		if not vim.g.neovide then
			require("smear_cursor").setup({})
		end
	end,
}
