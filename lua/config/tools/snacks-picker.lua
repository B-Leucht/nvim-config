-- Snacks picker keymaps - preserving your original fzf-lua keymaps and functionality
local keymap = vim.keymap.set

-- ===============================================
-- FILE FINDING (preserving your original fzf keymaps)
-- ===============================================

-- File finding - test if snacks.picker methods exist
keymap("n", "<leader>ff", function()
	local ok, err = pcall(Snacks.picker.files)
	if not ok then
		vim.notify("Snacks.picker.files error: " .. err, vim.log.levels.ERROR)
	end
end, { desc = "Find files", silent = true })

keymap("n", "<leader>fF", function()
	local ok, err = pcall(Snacks.picker.git_files)
	if not ok then
		vim.notify("Snacks.picker.git_files error: " .. err, vim.log.levels.ERROR)
	end
end, { desc = "Find git files", silent = true })

keymap("n", "<leader>fr", function()
	local ok, err = pcall(Snacks.picker.recent)
	if not ok then
		vim.notify("Snacks.picker.recent error: " .. err, vim.log.levels.ERROR)
	end
end, { desc = "Recent files", silent = true })

keymap("n", "<leader>fb", function()
	local ok, err = pcall(Snacks.picker.buffers)
	if not ok then
		vim.notify("Snacks.picker.buffers error: " .. err, vim.log.levels.ERROR)
	end
end, { desc = "Buffers", silent = true })

-- ===============================================
-- TEXT SEARCHING (preserving your original fzf keymaps)
-- ===============================================

keymap("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Live grep", silent = true })

keymap("n", "<leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep word under cursor", silent = true })

keymap("n", "<leader>fW", function()
	Snacks.picker.grep_word({ word_match = false })
end, { desc = "Grep WORD under cursor", silent = true })

keymap("v", "<leader>fg", function()
	Snacks.picker.grep_selection()
end, { desc = "Grep selection", silent = true })

-- ===============================================
-- LSP INTEGRATION (preserving your original fzf keymaps)
-- ===============================================

keymap("n", "<leader>ls", function()
	Snacks.picker.lsp_symbols()
end, { desc = "Document symbols" })

keymap("n", "<leader>lS", function()
	Snacks.picker.lsp_symbols({ workspace = true })
end, { desc = "Workspace symbols" })

keymap("n", "<leader>lr", function()
	Snacks.picker.lsp_references()
end, { desc = "LSP references" })

keymap("n", "<leader>ld", function()
	Snacks.picker.lsp_definitions()
end, { desc = "LSP definitions" })

keymap("n", "<leader>li", function()
	Snacks.picker.lsp_implementations()
end, { desc = "LSP implementations" })

keymap("n", "<leader>lt", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "LSP type definitions" })

keymap("n", "<leader>la", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP code actions" })

keymap("n", "<leader>lx", function()
	Snacks.picker.diagnostics()
end, { desc = "Document diagnostics" })

keymap("n", "<leader>lX", function()
	Snacks.picker.diagnostics({ workspace = true })
end, { desc = "Workspace diagnostics" })

-- ===============================================
-- GIT INTEGRATION (preserving your original fzf keymaps)
-- ===============================================

keymap("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, { desc = "Git branches", silent = true })

keymap("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git status", silent = true })

keymap("n", "<leader>gc", function()
	Snacks.picker.git_log()
end, { desc = "Git commits", silent = true })

keymap("n", "<leader>gC", function()
	Snacks.picker.git_log({ current_file = true })
end, { desc = "Buffer commits", silent = true })

-- ===============================================
-- UTILITY (preserving your original fzf keymaps)
-- ===============================================

keymap("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Help tags", silent = true })

keymap("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps", silent = true })

keymap("n", "<leader>fc", function()
	Snacks.picker.commands()
end, { desc = "Commands", silent = true })

keymap("n", "<leader>fm", function()
	Snacks.picker.marks()
end, { desc = "Marks", silent = true })

keymap("n", "<leader>fj", function()
	Snacks.picker.jumps()
end, { desc = "Jumps", silent = true })

keymap("n", "<leader>fz", function()
	Snacks.picker.resume()
end, { desc = "Resume last search", silent = true })

-- ===============================================
-- TODO COMMENTS (preserving your original fzf keymap)
-- ===============================================

keymap("n", "<leader>ft", function()
	Snacks.picker.grep({ search = "TODO|FIXME|HACK|WARN|PERF|NOTE" })
end, { desc = "Find todos" })