-- Snacks configuration combining all modules
local dashboard = require("config.snacks.dashboard")
local picker = require("config.snacks.picker")
local notifier = require("config.snacks.notifier")
local terminal = require("config.snacks.terminal")
local core = require("config.snacks.core")

-- Return combined configuration for snacks.setup()
return vim.tbl_deep_extend("force", {
	dashboard = dashboard,
	picker = picker,
	notifier = notifier,
	terminal = terminal,
}, core)

