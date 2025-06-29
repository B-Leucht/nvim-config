local constants = require("core.constants")

-- Disable netrw (using Oil.nvim instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- Tabs and indentation
opt.tabstop = 4 -- Number of spaces tabs count for
opt.shiftwidth = 4 -- Number of spaces for auto-indent
opt.softtabstop = 4 -- Number of spaces for tab input
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart autoindenting on new lines
opt.autoindent = true -- Copy indent from current line when starting a new one

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = false -- Relative line numbers
opt.cursorline = true -- Highlight current line
opt.wrap = false -- No line wrap
opt.signcolumn = "auto" -- Show sign column only when needed
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true -- Case insensitive search...
opt.smartcase = true -- ...unless capitals are used
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show search results as typing

-- Behavior
opt.mouse = "a" -- Enable mouse
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true -- Persistent undo
opt.backup = true
opt.backupdir = constants.PATHS.BACKUP_DIR
opt.swapfile = false -- No swap files

-- Splits
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits to the right

-- Appearance
opt.termguicolors = true -- True color support
opt.showmode = false -- Don’t show mode (use statusline instead)
opt.laststatus = 3 -- Global statusline

-- Performance
opt.updatetime = constants.UI.UPDATE_TIME
opt.timeoutlen = constants.UI.TIMEOUT

-- File detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable") -- Use `enable` instead of `on` (more standard)
vim.diagnostic.config({
	virtual_text = false,
})

-- Neovide-specific settings
if vim.g.neovide then
	-- Fix key handling for GUI
	vim.g.neovide_input_use_logo = 1 -- Use Cmd key on macOS
	vim.g.neovide_input_macos_options_key_is_meta = "only_left"

	-- Cursor settings
	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_size = 0.3
	vim.g.neovide_opacity = constants.APPEARANCE.OPACITY
	vim.g.neovide_scale_factor = constants.APPEARANCE.SCALE_FACTOR
	vim.o.guifont = constants.APPEARANCE.FONT
end
