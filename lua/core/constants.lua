-- Configuration constants
local M = {}

-- UI Constants
M.UI = {
	PANEL_HEIGHT = 10,
	SIDEBAR_WIDTH = 10,
	WINDOW_SCALE = 0.8,
	TIMEOUT = 400,
	UPDATE_TIME = 1000,
}

-- Appearance
M.APPEARANCE = {
	FONT = "FiraCode Nerd Font:h18",
	THEME = "catppuccin",
	FLAVOR = "mocha",
	OPACITY = 0.95,
	SCALE_FACTOR = 1.0,
}

-- File paths
M.PATHS = {
	BACKUP_DIR = vim.fn.stdpath("config") .. "/backup/",
	CONFIG_DIR = vim.fn.stdpath("config"),
	INIT_LUA = vim.fn.stdpath("config") .. "/init.lua",
	KEYMAPS = vim.fn.stdpath("config") .. "/lua/config/keymaps.lua",
	PLUGINS = vim.fn.stdpath("config") .. "/lua/plugins/init.lua",
}

-- Keybinding options
M.OPTS = {
	SILENT = { noremap = true, silent = true },
	BUFFER = function(bufnr)
		return { noremap = true, silent = true, buffer = bufnr }
	end,
}

-- Terminal options
M.TERMINAL = {
	SIZE = 15,
	FLOAT_WIDTH_RATIO = 0.8,
	FLOAT_HEIGHT_RATIO = 0.8,
}

-- Float window dimensions
M.FLOAT = {
	WIDTH = 0.8,
	HEIGHT = 0.8,
	PADDING = 2,
}

return M
