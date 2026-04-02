local gh = require("utils.gh")

return {
	specs = { gh("Davidyz/inlayhint-filler.nvim") },
	setup = function()
		require("inlayhint-filler").setup({ force = true })
	end,
}
