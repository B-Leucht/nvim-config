-- Disable netrw (since you use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor settings
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
opt.signcolumn = "yes" -- Always show sign column
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true -- Case insensitive search...
opt.smartcase = true -- ...unless you use capitals
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show search results as you type

-- Behavior
opt.mouse = "a" -- Enable mouse
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true -- Persistent undo
opt.backup = true
opt.backupdir = vim.fn.expand("~/.config/nvim/backup//")
opt.swapfile = false -- No swap files

-- Splits
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits to the right

-- Appearance
opt.termguicolors = true -- True color support
opt.showmode = false -- Don’t show mode (use statusline instead)
opt.laststatus = 3 -- Global statusline

-- Performance
opt.updatetime = 300 -- Faster diagnostics
opt.timeoutlen = 400 -- Time to wait for mapped sequence

-- File detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable") -- Use `enable` instead of `on` (more standard)
vim.diagnostic.config({
  virtual_text = false,
})
