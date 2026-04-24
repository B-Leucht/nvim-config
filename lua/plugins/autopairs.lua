local gh = require("utils.gh")

return {
	specs = { gh("windwp/nvim-autopairs") },
	setup = function()
		require("nvim-autopairs").setup({
			check_ts = true,
			fast_wrap = {},
		})
	end,
}
