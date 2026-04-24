vim.loader.enable()
require("vim._core.ui2").enable({
  msg
  = { targets = "msg", msg = { timeout = 3000, }, },
})
require("options")
require("keymaps")
require("plugins.init")
