local gh = require("utils.gh")

return {
	specs = { gh("aznhe21/actions-preview.nvim") },
	setup = function()
		require("actions-preview").setup({
			backend = { "snacks" },
		})
	end,
}
