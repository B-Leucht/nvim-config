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
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Better buffer deletion with bufdelete.nvim
keymap("n", "<leader>bd", function()
	require("bufdelete").bufdelete(0, true)
end, { desc = "Delete buffer (keep window)" })

keymap("n", "<leader>bD", function()
	require("bufdelete").bufdelete(0, false)
end, { desc = "Force delete buffer" })

-- BufferLine specific commands
keymap("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
keymap("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })
keymap("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

-- Go to specific buffers (BufferLine numbers)
for i = 1, 9 do
	keymap("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end
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

keymap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
keymap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]])
keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]])

-- ===============================================
-- FILE EXPLORER
-- ===============================================

-- NvimTree
--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", noremap = true, silent = true })

keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>E", "<cmd>Oil --float<cr>", { desc = "Open Oil in floating window" })

-- ===============================================
-- FUZZY FINDER (FZF-LUA)
-- ===============================================

keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files", silent = true })
keymap("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep", silent = true })
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers", silent = true })
keymap("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "Help tags", silent = true })
keymap("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Resume", silent = true })
keymap("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", opts)
keymap("n", "<leader>fs", "<cmd>FzfLua grep_cword<CR>", opts)
keymap("n", "<leader>fS", "<cmd>FzfLua grep_cWORD<CR>", opts)
keymap("n", "<leader>fc", "<cmd>FzfLua commands<cr>", { desc = "Find commands" })

-- LSP integration with FZF-Lua
keymap("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document symbols" })
keymap("n", "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<cr>", { desc = "Workspace symbols" })
keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>", { desc = "LSP references" })
keymap("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", { desc = "LSP definitions" })
keymap("n", "<leader>li", "<cmd>FzfLua lsp_implementations<cr>", { desc = "LSP implementations" })
-- Git with FZF
keymap("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", opts)
keymap("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", opts)

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

-- Vim Fugitive
keymap("n", "<leader>gj", "<cmd>diffget //3<CR>", opts)
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", opts)

-- Gitsigns
keymap("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", opts)
keymap("v", "<leader>ghs", ":Gitsigns stage_hunk<CR>", opts)
keymap("v", "<leader>ghr", ":Gitsigns reset_hunk<CR>", opts)
keymap("n", "<leader>ghS", "<cmd>Gitsigns stage_buffer<CR>", opts)
keymap("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
keymap("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<CR>", opts)
keymap("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>ghb", function()
	require("gitsigns").blame_line({ full = true })
end, opts)
keymap("n", "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
keymap("n", "<leader>ghd", "<cmd>Gitsigns diffthis<CR>", opts)
keymap("n", "<leader>ghD", function()
	require("gitsigns").diffthis("~")
end, opts)
keymap("n", "<leader>gtd", "<cmd>Gitsigns toggle_deleted<CR>", opts)

-- Diffview (if using)
keymap("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", opts)
keymap("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", opts)
keymap("n", "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", opts)

-- ===============================================
-- TERMINAL (TOGGLETERM)
-- ===============================================

keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", opts)
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", opts)

-- Terminal mode keymaps (YOUR CONFIGURATION)
function _G.set_terminal_keymaps()
	local term_opts = { buffer = 0 }
	keymap("t", "<esc>", [[<C-\><C-n>]], term_opts)
	keymap("t", "jk", [[<C-\><C-n>]], term_opts)
	keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
	keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
	keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
	keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)
	keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], term_opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- ===============================================
-- COMPILER & OVERSEER
-- ===============================================

-- Leader-based mappings (cleaner and more consistent)
keymap("n", "<leader>co", "<cmd>CompilerOpen<CR>", opts)
keymap("n", "<leader>cr", "<cmd>CompilerRedo<CR>", opts)
keymap("n", "<leader>ct", "<cmd>CompilerToggleResults<CR>", opts)
keymap("n", "<leader>cs", "<cmd>CompilerStop<CR>", opts)

-- F-key mappings (your original setup - kept as alternatives)
-- vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-F6>", "<cmd>CompilerStop<cr><cmd>CompilerRedo<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

-- ===============================================
-- COMMENT
-- ===============================================

-- Comment.nvim keymaps are set automatically:
-- gcc - toggle line comment
-- gbc - toggle block comment
-- gc{motion} - line comment with motion
-- gb{motion} - block comment with motion

-- ===============================================
-- COPILOT (YOUR TOGGLE SETUP)
-- ===============================================

-- Copilot toggle
local copilot_enabled = true
keymap("n", "<leader>cp", function()
	copilot_enabled = not copilot_enabled
	vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
	print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
end, { desc = "Toggle Copilot" })

-- Copilot accept
keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- ===============================================
-- AVANTE AI
-- ===============================================

keymap("n", "<leader>aa", function()
	require("avante.api").ask()
end, { desc = "avante: ask" })
keymap("v", "<leader>aa", function()
	require("avante.api").ask()
end, { desc = "avante: ask" })
keymap("n", "<leader>ar", function()
	require("avante.api").refresh()
end, { desc = "avante: refresh" })
keymap("n", "<leader>ae", function()
	require("avante.api").edit()
end, { desc = "avante: edit" })

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

keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
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
keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

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
-- WHICH-KEY DESCRIPTIONS
-- ===============================================

-- Register descriptions for which-key
local which_key_ok, which_key = pcall(require, "which-key")
if which_key_ok then
	which_key.add({
		{ "<leader>f", group = "+find" },
		{ "<leader>g", group = "+git" },
		{ "<leader>gh", group = "+hunks" },
		{ "<leader>gt", group = "+toggle" },
		{ "<leader>l", group = "+lsp" }, -- Changed from latex
		{ "<leader>t", group = "+terminal" },
		{ "<leader>c", group = "+compiler" }, -- More specific
		{ "<leader>w", group = "+workspace" },
		{ "<leader>x", group = "+diagnostics" },
		{ "<leader>a", group = "+ai/avante" },
		{ "<leader>s", group = "+saga/show" },
		{ "<leader>e", group = "+edit" }, -- New group for config editing
		{ "<leader>m", group = "+marks" }, -- New group for harpoon
		{ "<leader>se", group = "+session" }, -- New group for sessions
		{ "<leader>vt", group = "+vimtex" }, -- New group for VimTeX (if using option 2)
		{ "<leader>tex", group = "+latex" }, -- New group for VimTeX (if using option 1)
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
-- keymap("n", "<up>", "<nop>", opts)
-- keymap("n", "<down>", "<nop>", opts)
-- keymap("n", "<left>", "<nop>", opts)
-- keymap("n", "<right>", "<nop>", opts)", "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", opts)
