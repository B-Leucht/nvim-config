local gh = function(x)
	return "https://github.com/" .. x
end

return {
	specs = { gh("OXY2DEV/foldtext.nvim") },
	setup = function()
		require("foldtext").setup({
			styles = {
				default = {
					{ kind = "indent" },
					{ kind = "bufline" },
					{ kind = "fold_size", hl = "@comment", icon = " 󰁂 " },
				},
			},
		})
	end,
}
