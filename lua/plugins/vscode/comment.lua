-- ===============================================
-- COMMENTS
-- ===============================================
return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
		{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
	},
	config = function()
		require("Comment").setup({
			-- Disable default mappings to avoid conflicts
			mappings = {
				basic = true,
				extra = false,
			},
		})
	end,
}