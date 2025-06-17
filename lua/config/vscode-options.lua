-- ===============================================
-- File: ~/.config/nvim/lua/config/vscode-options.lua
-- ===============================================

-- VS Code specific options
local opt = vim.opt

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic editor settings
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true

-- Better completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Disable some features that conflict with VS Code
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 300
