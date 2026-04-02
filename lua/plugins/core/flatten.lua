local gh = require("utils.gh")

return {
	specs = { gh("willothy/flatten.nvim") },
	setup = function()
		require("flatten").setup({
			window = { open = "alternate" },
		})
	end,
}
