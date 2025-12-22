local constants = require("core.constants")

-- Disable netrw (using Oil.nvim instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Lualine LSP names display
vim.g.custom_lualine_show_lsp_names = true

local opt = vim.opt

-- Tabs and indentation
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Number of spaces for auto-indent
opt.softtabstop = 2 -- Number of spaces for tab input
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart autoindenting on new lines
opt.autoindent = true -- Copy indent from current line when starting a new one

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.numberwidth = 1 -- Minimum width of line number gutter
opt.signcolumn = "yes" -- Sign column on left side only
opt.foldcolumn = "0" -- No fold column to eliminate right padding
opt.cursorline = true -- Enable cursorline for CursorLineNr highlight
opt.wrap = true -- Enable line wrap
opt.textwidth = 80 -- Set line width for hard wrapping
opt.formatoptions = "tcqjrn1" -- Auto-wrap text and comments, insert comment leader, break long lines
opt.wrapmargin = 0 -- Use textwidth instead of wrapmargin
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8
opt.conceallevel = 0 -- Show all text including markers
opt.concealcursor = "" -- Show concealed text when cursor is on the line

-- Search
opt.ignorecase = true -- Case insensitive search...
opt.smartcase = true -- ...unless capitals are used
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show search results as typing

-- Behavior
opt.mouse = "a" -- Enable mouse
opt.mousemodel = "popup"
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
opt.laststatus = 2 -- Global statusline

-- Performance
opt.updatetime = constants.UI.UPDATE_TIME
opt.timeoutlen = constants.UI.TIMEOUT

-- Fix terminal rendering issues in windowed mode
local term_program = os.getenv("TERM_PROGRAM")
if term_program == "iTerm.app" or term_program == "Apple_Terminal" then
	vim.opt.ttyfast = true
	vim.opt.ttimeout = true
	-- vim.opt.ttimeoutlen = 50
end

-- File detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable") -- Use `enable` instead of `on` (more standard)
vim.diagnostic.config({
	virtual_text = false, -- Disable persistent virtual text
	float = {
		focusable = false,
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "rounded",
		source = "always",
		prefix = " ",
		scope = "cursor",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = " ",
			scope = "cursor",
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})

-- Neovide-specific settings
if vim.g.neovide then
	-- Platform-specific key handling
	if vim.fn.has("macunix") == 1 then
		vim.g.neovide_input_use_logo = 1 -- Use Cmd key on macOS
		vim.g.neovide_input_macos_options_key_is_meta = "only_left"
	end

	vim.g.neovide_title_hidden = 1
	vim.g.neovide_frame = "buttonless"
	-- Disable cursor animations to prevent flickering
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_opacity = constants.APPEARANCE.OPACITY
	vim.g.neovide_scale_factor = constants.APPEARANCE.SCALE_FACTOR
	vim.o.guifont = constants.APPEARANCE.FONT
end
