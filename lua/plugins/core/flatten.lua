local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("willothy/flatten.nvim") },
	setup = function()
		require("flatten").setup({
			window = { open = "alternate" },
		})
	end,
}
