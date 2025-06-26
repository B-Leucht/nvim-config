-- ===============================================
-- File: ~/.config/nvim/lua/config/vscode-keymaps.lua
-- ===============================================

-- VS Code specific keymaps
local constants = require("core.constants")
local keymap = vim.keymap.set
local opts = constants.OPTS.SILENT

-- VS Code command helper function
local function vscode_action(action)
	return function()
		vim.fn.VSCodeNotify(action)
	end
end

local function vscode_action_with_range(action)
	return function()
		vim.fn.VSCodeNotifyRange(action, vim.fn.line("v"), vim.fn.line("."), vim.api.nvim_get_vvar("count1"))
	end
end

-- ===============================================
-- EDITOR NAVIGATION
-- ===============================================

-- Better window navigation
keymap("n", "<C-h>", vscode_action("workbench.action.navigateLeft"), opts)
keymap("n", "<C-j>", vscode_action("workbench.action.navigateDown"), opts)
keymap("n", "<C-k>", vscode_action("workbench.action.navigateUp"), opts)
keymap("n", "<C-l>", vscode_action("workbench.action.navigateRight"), opts)

-- Tab navigation
keymap("n", "<Tab>", vscode_action("workbench.action.nextEditor"), opts)
keymap("n", "<S-Tab>", vscode_action("workbench.action.previousEditor"), opts)

-- File explorer
keymap("n", "<leader>e", vscode_action("workbench.action.toggleSidebarVisibility"), opts)
keymap("n", "<leader>o", vscode_action("workbench.files.action.focusFilesExplorer"), opts)

-- ===============================================
-- FILE OPERATIONS
-- ===============================================

-- File management
keymap("n", "<leader>ff", vscode_action("workbench.action.quickOpen"), opts)
keymap("n", "<leader>fg", vscode_action("workbench.action.findInFiles"), opts)
keymap("n", "<leader>fr", vscode_action("workbench.action.openRecent"), opts)
keymap("n", "<leader>fc", vscode_action("workbench.action.showCommands"), opts)
keymap("n", "<leader>fs", vscode_action("workbench.action.files.save"), opts)
keymap("n", "<leader>fa", vscode_action("workbench.action.files.saveAll"), opts)

-- Buffer/Tab management
keymap("n", "<leader>bd", vscode_action("workbench.action.closeActiveEditor"), opts)
keymap("n", "<leader>bc", vscode_action("workbench.action.closeOtherEditors"), opts)
keymap("n", "<leader>ba", vscode_action("workbench.action.closeAllEditors"), opts)

-- ===============================================
-- CODE NAVIGATION & LSP
-- ===============================================

-- Go to definition/references
keymap("n", "gd", vscode_action("editor.action.revealDefinition"), opts)
keymap("n", "gD", vscode_action("editor.action.revealDeclaration"), opts)
keymap("n", "gi", vscode_action("editor.action.goToImplementation"), opts)
keymap("n", "gr", vscode_action("editor.action.goToReferences"), opts)
keymap("n", "gt", vscode_action("editor.action.goToTypeDefinition"), opts)

-- Documentation and hover
keymap("n", "K", vscode_action("editor.action.showHover"), opts)
keymap("n", "<C-k>", vscode_action("editor.action.triggerParameterHints"), opts)

-- Code actions
keymap("n", "<leader>ca", vscode_action("editor.action.quickFix"), opts)
keymap("v", "<leader>ca", vscode_action_with_range("editor.action.quickFix"), opts)
keymap("n", "<leader>rn", vscode_action("editor.action.rename"), opts)

-- Diagnostics
keymap("n", "<leader>d", vscode_action("editor.action.showHover"), opts)
keymap("n", "[d", vscode_action("editor.action.marker.prevInFiles"), opts)
keymap("n", "]d", vscode_action("editor.action.marker.nextInFiles"), opts)
keymap("n", "<leader>xx", vscode_action("workbench.actions.view.problems"), opts)

-- ===============================================
-- CODE EDITING
-- ===============================================

-- Formatting
keymap("n", "<leader>f", vscode_action("editor.action.formatDocument"), opts)
keymap("v", "<leader>f", vscode_action_with_range("editor.action.formatSelection"), opts)

-- Code folding
keymap("n", "za", vscode_action("editor.toggleFold"), opts)
keymap("n", "zc", vscode_action("editor.fold"), opts)
keymap("n", "zo", vscode_action("editor.unfold"), opts)
keymap("n", "zM", vscode_action("editor.foldAll"), opts)
keymap("n", "zR", vscode_action("editor.unfoldAll"), opts)

-- Multi-cursor
keymap("n", "<C-d>", vscode_action("editor.action.addSelectionToNextFindMatch"), opts)
keymap("n", "<C-S-d>", vscode_action("editor.action.selectHighlights"), opts)

-- Line manipulation
keymap("n", "<A-j>", vscode_action("editor.action.moveLinesDownAction"), opts)
keymap("n", "<A-k>", vscode_action("editor.action.moveLinesUpAction"), opts)
keymap("v", "<A-j>", vscode_action_with_range("editor.action.moveLinesDownAction"), opts)
keymap("v", "<A-k>", vscode_action_with_range("editor.action.moveLinesUpAction"), opts)

-- Duplicate line
keymap("n", "<S-A-j>", vscode_action("editor.action.copyLinesDownAction"), opts)
keymap("n", "<S-A-k>", vscode_action("editor.action.copyLinesUpAction"), opts)

-- ===============================================
-- SEARCH AND REPLACE
-- ===============================================

-- Search
keymap("n", "/", vscode_action("actions.find"), opts)
keymap("n", "?", vscode_action("actions.find"), opts)
keymap("n", "*", vscode_action("editor.action.wordHighlight.next"), opts)
keymap("n", "#", vscode_action("editor.action.wordHighlight.prev"), opts)

-- Replace
keymap("n", "<leader>sr", vscode_action("editor.action.startFindReplaceAction"), opts)
keymap("n", "<leader>sR", vscode_action("workbench.action.replaceInFiles"), opts)

-- Clear search highlight
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- ===============================================
-- WORKSPACE MANAGEMENT
-- ===============================================

-- Split management
keymap("n", "<leader>sv", vscode_action("workbench.action.splitEditor"), opts)
keymap("n", "<leader>sh", vscode_action("workbench.action.splitEditorDown"), opts)
keymap("n", "<leader>sx", vscode_action("workbench.action.closeActiveEditor"), opts)

-- Terminal
keymap("n", "<leader>tt", vscode_action("workbench.action.terminal.toggleTerminal"), opts)
keymap("n", "<leader>tn", vscode_action("workbench.action.terminal.new"), opts)

-- Git
keymap("n", "<leader>gg", vscode_action("workbench.view.scm"), opts)
keymap("n", "<leader>gb", vscode_action("gitlens.toggleFileBlame"), opts)
keymap("n", "<leader>gc", vscode_action("git.commit"), opts)
keymap("n", "<leader>gp", vscode_action("git.push"), opts)
keymap("n", "<leader>gl", vscode_action("git.pull"), opts)

-- ===============================================
-- DEBUGGING
-- ===============================================

keymap("n", "<F5>", vscode_action("workbench.action.debug.start"), opts)
keymap("n", "<F9>", vscode_action("editor.debug.action.toggleBreakpoint"), opts)
keymap("n", "<F10>", vscode_action("workbench.action.debug.stepOver"), opts)
keymap("n", "<F11>", vscode_action("workbench.action.debug.stepInto"), opts)
keymap("n", "<S-F11>", vscode_action("workbench.action.debug.stepOut"), opts)

-- ===============================================
-- UTILITY KEYMAPS
-- ===============================================

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Stay in indent mode
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Quick save
keymap("n", "<leader>w", vscode_action("workbench.action.files.save"), opts)

-- Command palette
keymap("n", "<leader><leader>", vscode_action("workbench.action.showCommands"), opts)

-- Toggle zen mode
keymap("n", "<leader>z", vscode_action("workbench.action.toggleZenMode"), opts)

-- ===============================================
-- WHICH-KEY DESCRIPTIONS
-- ===============================================

local which_key_ok, which_key = pcall(require, "which-key")
if which_key_ok then
	which_key.register({
		["<leader>f"] = { name = "+find/file" },
		["<leader>g"] = { name = "+git" },
		["<leader>b"] = { name = "+buffer" },
		["<leader>s"] = { name = "+search/split" },
		["<leader>t"] = { name = "+terminal" },
		["<leader>c"] = { name = "+code" },
		["<leader>x"] = { name = "+diagnostics" },
	})
end
