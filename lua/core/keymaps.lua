local opts = require("core.constants").OPTS.SILENT
local keymap = vim.keymap.set
-- ===============================================
-- LEADER KEY
-- ===============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- Navigate buffers
keymap("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Jump to buffer by index
for i = 1, 9 do
	keymap("n", "<leader>b" .. i, function()
		local buffers = vim.api.nvim_list_bufs()
		local listed_buffers = {}

		-- Get only listed buffers (exclude hidden/unlisted ones)
		for _, buf in ipairs(buffers) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
				table.insert(listed_buffers, buf)
			end
		end

		if listed_buffers[i] then
			vim.api.nvim_set_current_buf(listed_buffers[i])
		else
			vim.notify("Buffer " .. i .. " not found", vim.log.levels.WARN)
		end
	end, { desc = "Jump to buffer " .. i })
end

-- Better buffer deletion with snacks.bufdelete
keymap("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer (keep window)" })

keymap("n", "<leader>bD", function()
	Snacks.bufdelete({ force = true })
end, { desc = "Force delete buffer" })

-- BufferLine specific commands
-- keymap("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
-- keymap("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to left" })
-- keymap("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to right" })
-- keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

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
		{ "<leader>w", group = "+workspace" },
		{ "<leader>x", group = "+diagnostics" },
		{ "<leader>a", group = "+ai/claude" },
		{ "<leader>s", group = "+saga/show/search" },
		{ "<leader>e", group = "+edit" },
		{ "<leader>vt", group = "+vimtex" },
	})
end

-- ===============================================
-- DISABLE ARROW KEYS (OPTIONAL)
-- ===============================================

-- Uncomment to disable arrow keys for better vim habits
keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("n", "<left>", "<nop>", opts)
keymap("n", "<right>", "<nop>", opts)

-- ===============================================
-- PLUGIN-SPECIFIC KEYMAPS
-- ===============================================
-- Plugin-specific keymaps are now defined in their respective plugin configurations
-- using the `keys` field for optimal lazy loading performance.
