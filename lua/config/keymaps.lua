-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float(nil, { focusable = false })
end, { desc = "Show line diagnostics" })

-- Copilot toggle
local copilot_enabled = true
vim.keymap.set("n", "<leader>cp", function()
	copilot_enabled = not copilot_enabled
	vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
	print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
end, { desc = "Toggle Copilot" })

-- Go to next/previous buffer (like tab switching)
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
