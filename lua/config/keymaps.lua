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

-- Toggle NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", noremap = true, silent = true })

-- Go to next/previous buffer (like tab switching)
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

-- LSP keymaps
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Toggle Nabla and MarkView
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

vim.keymap.set("n", "<leader>p", ToggleNablaMarkView, { desc = "Toggle Nabla / MarkView preview" })

--fzflua keymaps
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>", { desc = "Find files", silent = true })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep", silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Buffers", silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua help_tags<CR>", { desc = "Help tags", silent = true })
vim.keymap.set("n", "<leader>r", "<cmd>FzfLua resume<CR>", { desc = "Resume", silent = true })
