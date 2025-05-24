-- Set leader key early
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float(nil, { focusable = false })
end, { desc = "Show line diagnostics" })

vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})
]])

-- Copilot toggle
local copilot_enabled = true
vim.keymap.set("n", "<leader>cp", function()
	copilot_enabled = not copilot_enabled
	vim.cmd(copilot_enabled and "Copilot enable" or "Copilot disable")
	print("Copilot " .. (copilot_enabled and "enabled" or "disabled"))
end, { desc = "Toggle Copilot" })
