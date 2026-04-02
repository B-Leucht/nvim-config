vim.loader.enable()
require("vim._core.ui2").enable({
	msg = {
		targets = "msg",
		msg = {
			timeout = 3000,
		},
	},
})
require("core.options")
require("core.keymaps")
require("plugins.init")
