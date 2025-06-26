-- Additional snacks features: input, scope, toggle, words, scroll
local keymap = vim.keymap.set

-- ===============================================
-- SNACKS.INPUT - Enhanced vim.ui.input replacement
-- ===============================================
-- snacks.input automatically replaces vim.ui.input when enabled
-- Used by Oil remote path input and other plugins

-- Removed snacks.scope keymaps - scope navigation not working reliably

-- Removed snacks.toggle - too unreliable

-- ===============================================
-- SNACKS.WORDS - Word highlighting (replaces vim-illuminate)
-- ===============================================

-- Words are automatically highlighted when enabled
-- Removed snacks.words.jump - word navigation not working reliably

-- Removed snacks.words.toggle - word highlighting auto-enabled

-- ===============================================
-- SNACKS.SCROLL - Smooth scrolling (replaces neoscroll.nvim)
-- ===============================================

-- Scroll is automatically enabled and enhances default scrolling
-- No additional keymaps needed - works with existing scroll commands:
-- <C-u>, <C-d>, <C-b>, <C-f>, zt, zz, zb, gg, G, etc.

-- ===============================================
-- SNACKS.BUFDELETE - Buffer deletion (replaces mini.bufremove)
-- ===============================================

-- Buffer deletion keymaps are configured in core/keymaps.lua:
-- <leader>bd - Delete buffer (keep window)
-- <leader>bD - Force delete buffer

-- Additional buffer deletion functions available:
-- Snacks.bufdelete() - Delete current buffer
-- Snacks.bufdelete({ buf = buf_id }) - Delete specific buffer
-- Snacks.bufdelete({ force = true }) - Force delete
-- Snacks.bufdelete({ wipe = true }) - Wipe buffer

-- ===============================================
-- SNACKS.INDENT - Indentation guides (replaces indent-blankline.nvim)
-- ===============================================

-- Indent guides are automatically enabled and show indentation levels
-- No additional keymaps needed - works automatically with all file types

-- Removed snacks.toggle.indent - using snacks.indent auto-enabled