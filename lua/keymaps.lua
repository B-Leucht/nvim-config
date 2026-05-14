local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

keymap("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Jump to buffer by index
for i = 1, 9 do
	keymap("n", "<leader>b" .. i, function()
		local buffers = vim.api.nvim_list_bufs()
		local listed_buffers = {}
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

keymap("n", "<leader>bd", function()
	require("snacks").bufdelete()
end, { desc = "Delete buffer (keep window)" })

keymap("n", "<leader>bD", function()
	require("snacks").bufdelete({ force = true })
end, { desc = "Force delete buffer" })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })

-- Terminal
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("n", "<left>", "<nop>", opts)
keymap("n", "<right>", "<nop>", opts)

-- Undo break points at punctuation
for _, key in ipairs({ ",", ".", "!", "?", ";", ":" }) do
	keymap("i", key, key .. "<C-g>u")
end

-- Smart dd: empty lines go to black hole register
keymap("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	end
	return "dd"
end, { expr = true, desc = "Smart dd" })

vim.cmd.packadd("nvim.undotree")
keymap("n", "<leader>uu", "<cmd>Undotree<cr>", { desc = "Undotree" })

keymap({ "n", "v" }, "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

