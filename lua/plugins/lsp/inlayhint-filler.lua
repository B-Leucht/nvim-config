local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("Davidyz/inlayhint-filler.nvim") },
	setup = function()
		require("inlayhint-filler").setup({ force = true })
	end,
}
