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
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down (J/K in visual mode)
-- Note: Alt+j/k handled by mini.move
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- ===============================================
-- ADDITIONAL USEFUL KEYMAPS
-- ===============================================

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- Paste from system clipboard
keymap({ "n", "v" }, "<leader>P", '"+p', { desc = "Paste from clipboard" })

-- ===============================================
-- WHICH-KEY DESCRIPTIONS & HELPER
-- ===============================================

-- Which-key show buffer keymaps
keymap("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Toggle transparency
keymap("n", "<leader>ut", function()
	toggle_transparency()
end, { desc = "Toggle transparency" })

-- ===============================================
-- DISABLE ARROW KEYS (OPTIONAL)
-- ===============================================

-- Uncomment to disable arrow keys for better vim habits
keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("n", "<left>", "<nop>", opts)
keymap("n", "<right>", "<nop>", opts)

-- ===============================================
-- LSP KEYMAPS (using Snacks.keymap for LSP-aware keymaps)
-- Deferred until Snacks is loaded
-- ===============================================

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Code actions (only active when LSP supports it)
		Snacks.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, {
			lsp = { method = "textDocument/codeAction" },
			desc = "Code actions",
		})

		-- Hover documentation
		Snacks.keymap.set("n", "K", vim.lsp.buf.hover, {
			lsp = { method = "textDocument/hover" },
			desc = "Hover documentation",
		})


		-- Signature help
		Snacks.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {
			lsp = { method = "textDocument/signatureHelp" },
			desc = "Signature help",
		})

		-- Format document
		Snacks.keymap.set("n", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, {
			lsp = { method = "textDocument/formatting" },
			desc = "Format document",
		})

		-- Format selection
		Snacks.keymap.set("v", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, {
			lsp = { method = "textDocument/rangeFormatting" },
			desc = "Format selection",
		})

		-- Toggle inlay hints
		Snacks.keymap.set("n", "<leader>lh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, {
			lsp = { method = "textDocument/inlayHint" },
			desc = "Toggle inlay hints",
		})
	end,
})
