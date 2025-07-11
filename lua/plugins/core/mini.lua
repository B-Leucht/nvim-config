-- Mini.nvim collection
return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.comment").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()
	end,
}