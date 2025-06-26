local constants = require("core.constants")

-- Configure snacks.nvim terminal
require("snacks").setup({
	terminal = {
		win = {
			wo = {
				winbar = "",
			},
		},
	},
})

require("claudecode").setup({
	window = {
		width = constants.UI.SIDEBAR_WIDTH / 100,
	},
})

