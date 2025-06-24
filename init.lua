--t Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- VS Code Neovim detection and early exit
if vim.g.vscode then
	-- Load minimal VS Code specific config
	require("plugins.vscode")
	require("config.vscode-options")
	require("config.vscode-keymaps")
	return
end
-- Load core config
require("config.options")
require("config.keymaps")

-- Load plugin setup
require("plugins.init")
