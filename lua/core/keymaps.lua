-- ~/.config/nvim/lua/config/keymaps.lua
-- ===============================================
-- CONSOLIDATED KEYMAPS CONFIGURATION
-- ===============================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ===============================================
-- LEADER KEY
-- ===============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ===============================================
-- CONFIG KEYMAPS
-- ===============================================

keymap("n", "<leader>ec", "<cmd>e ~/.config/nvim/init.lua<cr>", { desc = "Edit config" })
keymap("n", "<leader>ek", "<cmd>e ~/.config/nvim/lua/config/keymaps.lua<cr>", { desc = "Edit keymaps" })
keymap("n", "<leader>ep", "<cmd>e ~/.config/nvim/lua/plugins/init.lua<cr>", { desc = "Edit plugins" })
keymap("n", "<leader>er", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Reload config" })

-- ===============================================
-- BASIC VIM KEYMAPS
-- ===============================================

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers (using BufferLine)
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
-- Better buffer deletion with snacks.bufdelete
keymap("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer (keep window)" })

keymap("n", "<leader>bD", function()
	Snacks.bufdelete({ force = true })
end, { desc = "Force delete buffer" })

-- BufferLine specific commands
keymap("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
keymap("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })
keymap("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- ===============================================
-- DIAL.NVIM (INCREMENT/DECREMENT)
-- ===============================================

keymap("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end)
keymap("n", "<C-x>", function()
	require("dial.map").manipulate("decrement", "normal")
end)
keymap("n", "g<C-a>", function()
	require("dial.map").manipulate("increment", "gnormal")
end)
keymap("n", "g<C-x>", function()
	require("dial.map").manipulate("decrement", "gnormal")
end)
keymap("v", "<C-a>", function()
	require("dial.map").manipulate("increment", "visual")
end)
keymap("v", "<C-x>", function()
	require("dial.map").manipulate("decrement", "visual")
end)
keymap("v", "g<C-a>", function()
	require("dial.map").manipulate("increment", "gvisual")
end)
keymap("v", "g<C-x>", function()
	require("dial.map").manipulate("decrement", "gvisual")
end)

-- ===============================================
-- Better Search and Highlighting
-- ===============================================

-- keymap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
-- keymap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
-- keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]])
-- keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]])

-- ===============================================
-- FILE EXPLORER
-- ===============================================

-- NvimTree
--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", noremap = true, silent = true })

-- Smart Oil keymap - disabled in terminals/special buffers
keymap("n", "-", function()
	local ft = vim.bo.filetype
	if ft == "snacks_terminal" or ft == "terminal" or ft == "claude" or ft == "trouble" then
		return
	end
	vim.cmd("Oil")
end, { desc = "Open parent directory" })
keymap("n", "<leader>E", "<cmd>Oil --float<cr>", { desc = "Open Oil in floating window" })
local open_remote = function()
	vim.ui.input({ prompt = "Remote path (oil-ssh://user@host/path): " }, function(input)
		if input then
			vim.cmd("Oil " .. input)
		end
	end)
end
keymap("n", "<leader>Er", open_remote, { desc = "Open remote directory in Oil" })

-- ===============================================
-- FUZZY FINDER (SNACKS.PICKER)
-- ===============================================
-- Keymaps are configured in snacks-picker.lua

-- ===============================================
-- LSP KEYMAPS
-- ===============================================

local function lsp_keymaps(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Navigation
	keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
	keymap("n", "gt", vim.lsp.buf.type_definition, bufopts)

	-- Documentation
	keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

	-- Workspace
	keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)

	-- Diagnostics
	keymap("n", "<leader>d", function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end, { desc = "Show line diagnostics" })
	keymap("n", "[d", vim.diagnostic.goto_prev, bufopts)
	keymap("n", "]d", vim.diagnostic.goto_next, bufopts)
	keymap("n", "<leader>q", vim.diagnostic.setloclist, bufopts)

	-- Formatting
	keymap("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- Set up LSP keymaps when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		lsp_keymaps(ev.buf)
	end,
})

-- ===============================================
-- LSPSAGA KEYMAPS
-- ===============================================

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Additional Lspsaga mappings
keymap("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "<leader>gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

-- ===============================================
-- GIT KEYMAPS
-- ===============================================

-- -- Lazygit (main git interface - floating terminal)
-- local Terminal  = require('toggleterm').Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
--
-- function _lazygit_toggle()
--   lazygit:toggle()
-- end
--
-- keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- Diffview (enhanced git diffs)
keymap("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", opts)
keymap("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", opts)
keymap("n", "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", opts)

-- ===============================================
-- TERMINAL (SNACKS.TERMINAL)
-- ===============================================
-- Keymaps are configured in snacks-terminal.lua

-- ===============================================
-- COMPILER & OVERSEER
-- ===============================================

-- Leader-based mappings (cleaner and more consistent)
keymap("n", "<leader>co", "<cmd>CompilerOpen<CR>", opts)
keymap("n", "<leader>cr", "<cmd>CompilerRedo<CR>", opts)
keymap("n", "<leader>ct", "<cmd>CompilerToggleResults<CR>", opts)
keymap("n", "<leader>cs", "<cmd>CompilerStop<CR>", opts)

-- F-key mappings (kept as alternatives)
-- keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { desc = "Open compiler" })
-- keymap("n", "<S-F6>", "<cmd>CompilerStop<cr><cmd>CompilerRedo<cr>", { desc = "Restart compiler" })
-- keymap("n", "<S-F7>", "<cmd>CompilerToggleResults<cr>", { desc = "Toggle compiler results" })

-- ===============================================
-- CODE EDITING & UTILITIES
-- ===============================================

-- mini.comment keymaps are set automatically:
-- gcc - toggle line comment
-- gbc - toggle block comment
-- gc{motion} - line comment with motion
-- gb{motion} - block comment with motion

-- Sniprun (code execution)
keymap("n", "<leader>r", "<Plug>SnipRun", { desc = "Run code snippet" })
keymap("v", "<leader>r", "<Plug>SnipRun", { desc = "Run code snippet" })
keymap("n", "<leader>rc", "<Plug>SnipClose", { desc = "Close sniprun" })
keymap("n", "<leader>rt", "<Plug>SnipTerminate", { desc = "Terminate sniprun" })

-- Spectre (Search & Replace)
-- keymap("n", "<leader>sr", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre (Search & Replace)" })
-- keymap(
-- 	"n",
-- 	"<leader>sw",
-- 	'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
-- 	{ desc = "Search current word" }
-- )
-- keymap("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search selected text" })
-- keymap(
-- 	"n",
-- 	"<leader>sf",
-- 	'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
-- 	{ desc = "Search in current file" }
-- )

-- ===============================================
-- AI ASSISTANCE
-- ===============================================

-- Copilot
local copilot_enabled = true
keymap("n", "<leader>cp", function()
	copilot_enabled = not copilot_enabled
	vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
	print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
end, { desc = "Toggle Copilot" })

keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- Claude Code (Smart replacement with symbols)
keymap("n", "<leader>a", function() end, { desc = "AI/Claude Code" })
keymap("n", "<leader>ac", function()
	-- Check if symbols trouble is open in right sidebar
	local symbols_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
		if ft == "trouble" and name:match("symbols") then
			symbols_win = win
			break
		end
	end

	if symbols_win then
		-- Close symbols and open Claude in same position
		vim.api.nvim_win_close(symbols_win, false)
	end
	vim.cmd("ClaudeCode")
end, { desc = "Toggle Claude" })
keymap("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
keymap("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
keymap("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
keymap("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
keymap("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
keymap("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
keymap("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

-- ===============================================
-- MARKDOWN & MATH PREVIEW (YOUR TOGGLE SETUP)
-- ===============================================

-- Toggle Nabla and MarkView (YOUR FUNCTION)
local current_tool = nil

function ToggleNablaMarkView()
	if current_tool == "nabla" then
		require("nabla").disable_virt()
		vim.cmd("Markview Enable")
		current_tool = "markview"
		return
	elseif current_tool == "markview" then
		vim.cmd("Markview Disable")
		require("nabla").enable_virt({ autogen = true })
		current_tool = "nabla"
		return
	end

	-- Default: start with Nabla
	require("nabla").enable_virt({ autogen = true })
	current_tool = "nabla"
end

keymap("n", "<leader>p", ToggleNablaMarkView, { desc = "Toggle Nabla / MarkView preview" })

-- ===============================================
-- TROUBLE (DIAGNOSTICS)
-- ===============================================

-- Smart diagnostics trouble - shares bottom panel with terminal
keymap("n", "<leader>xx", function()
	-- Check if terminal is open in bottom panel
	local term_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
		local name = vim.api.nvim_buf_get_name(buf)
		if ft == "snacks_terminal" or name:match("term://") then
			term_win = win
			break
		end
	end

	if term_win then
		-- Close terminal and open diagnostics in same position
		vim.api.nvim_win_close(term_win, false)
	end
	vim.cmd("Trouble diagnostics toggle win.position=bottom")
end, { desc = "Diagnostics (Trouble)" })

keymap(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0 win.position=bottom<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
-- Smart symbols trouble - replaces Claude if open
keymap("n", "<leader>xs", function()
	-- Check if Claude is open in right sidebar
	local claude_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
		local name = vim.api.nvim_buf_get_name(buf)
		local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
		if ft == "claude" or name:match("claude") or bt == "terminal" and name:match("claude") then
			claude_win = win
			break
		end
	end

	if claude_win then
		-- Close Claude and open symbols in same position
		vim.api.nvim_win_close(claude_win, false)
		vim.cmd("Trouble symbols toggle focus=false win.position=right")
	else
		-- Normal symbols toggle
		vim.cmd("Trouble symbols toggle focus=false")
	end
end, { desc = "Symbols (Trouble)" })

keymap(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
keymap("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- ===============================================
-- FLASH (NAVIGATION)
-- ===============================================

keymap({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
keymap({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
keymap("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
keymap({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
keymap("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- ===============================================
-- TODO COMMENTS
-- ===============================================

keymap("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
keymap("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
-- Todo finding moved to snacks-picker.lua

-- ===============================================
-- VIMTEX
-- ===============================================

keymap("n", "<leader>vtl", "<cmd>VimtexCompile<CR>", { desc = "VimTeX compile" })
keymap("n", "<leader>vtv", "<cmd>VimtexView<CR>", { desc = "VimTeX view" })
keymap("n", "<leader>vts", "<cmd>VimtexStop<CR>", { desc = "VimTeX stop" })
keymap("n", "<leader>vtc", "<cmd>VimtexClean<CR>", { desc = "VimTeX clean" })
keymap("n", "<leader>vtC", "<cmd>VimtexClean!<CR>", { desc = "VimTeX clean all" })
keymap("n", "<leader>vte", "<cmd>VimtexErrors<CR>", { desc = "VimTeX errors" })
keymap("n", "<leader>vto", "<cmd>VimtexCompileOutput<CR>", { desc = "VimTeX output" })
keymap("n", "<leader>vtg", "<cmd>VimtexStatus<CR>", { desc = "VimTeX status" })
keymap("n", "<leader>vtG", "<cmd>VimtexStatusAll<CR>", { desc = "VimTeX status all" })
keymap("n", "<leader>vtt", "<cmd>VimtexTocToggle<CR>", { desc = "VimTeX TOC toggle" })

-- ===============================================
-- WHICH-KEY DESCRIPTIONS & HELPER
-- ===============================================

-- Which-key show buffer keymaps
keymap("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Register descriptions for which-key
local which_key_ok, which_key = pcall(require, "which-key")
if which_key_ok then
	which_key.add({
		{ "<leader>f", group = "+find" },
		{ "<leader>g", group = "+git" },
		{ "<leader>l", group = "+lsp" },
		{ "<leader>t", group = "+terminal" },
		{ "<leader>q", group = "+quickfile" },
		{ "<leader>r", group = "+run/rename" },
		{ "<leader>c", group = "+compiler" },
		{ "<leader>w", group = "+workspace" },
		{ "<leader>x", group = "+diagnostics" },
		{ "<leader>a", group = "+ai/claude" },
		{ "<leader>s", group = "+saga/show/search" },
		{ "<leader>e", group = "+edit" },
		{ "<leader>vt", group = "+vimtex" },
	})
end
-- ===============================================
-- ADDITIONAL USEFUL KEYMAPS
-- ===============================================

-- Quick save
keymap("n", "<leader>w", "<cmd>w<CR>", opts)

-- Quick quit
keymap("n", "<leader>q", "<cmd>q<CR>", opts)

-- Force quit
keymap("n", "<leader>Q", "<cmd>q!<CR>", opts)

-- Save and quit
keymap("n", "<leader>x", "<cmd>x<CR>", opts)

-- New line above/below without entering insert mode
keymap("n", "<leader>o", "o<Esc>", opts)
keymap("n", "<leader>O", "O<Esc>", opts)

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)

-- Paste from system clipboard
keymap({ "n", "v" }, "<leader>P", '"+p', opts)

-- ===============================================
-- DISABLE ARROW KEYS (OPTIONAL)
-- ===============================================

-- Uncomment to disable arrow keys for better vim habits
keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("n", "<left>", "<nop>", opts)
keymap("n", "<right>", "<nop>", opts)
