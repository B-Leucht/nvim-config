-- Advanced snacks features: zen, statuscolumn, dim, git, animate, quickfile, rename
local keymap = vim.keymap.set

-- ===============================================
-- SNACKS.ZEN - Distraction-free mode
-- ===============================================

-- Toggle zen mode (perfect for VimTeX writing) with error handling
keymap("n", "<leader>z", function()
	local ok, _ = pcall(function() Snacks.zen() end)
	if not ok then
		vim.notify("Snacks.zen not available", vim.log.levels.WARN)
	end
end, { desc = "Toggle Zen Mode" })

-- Zen mode with specific options (with error handling)
keymap("n", "<leader>Z", function()
	local ok, _ = pcall(function()
		Snacks.zen({
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				diagnostics = false,
				inlay_hints = false,
			},
			show = {
				statusline = false,
				tabline = false,
			},
			win = {
				width = 120, -- Ideal for writing
			},
		})
	end)
	if not ok then
		vim.notify("Snacks.zen not available", vim.log.levels.WARN)
	end
end, { desc = "Toggle Zen Mode (Writing)" })

-- ===============================================
-- SNACKS.STATUSCOLUMN - Enhanced gutter
-- ===============================================

-- Statuscolumn is automatically enabled and enhances the gutter with:
-- - Git signs integration
-- - Diagnostic signs
-- - Line numbers with better formatting
-- - Fold markers

-- ===============================================
-- SNACKS.DIM - Dim inactive code
-- ===============================================

-- Removed snacks.dim toggles - dimming auto-enabled

-- ===============================================
-- SNACKS.GIT - Git utilities
-- ===============================================

-- Git blame for current line
keymap("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "Git Blame Line" })

-- Git blame for entire file
keymap("n", "<leader>gB", function()
	Snacks.git.blame_file()
end, { desc = "Git Blame File" })

-- Browse git repository
keymap("n", "<leader>gR", function()
	Snacks.git.browse()
end, { desc = "Browse Git Repository" })

-- Open current file in git web UI
keymap("n", "<leader>gO", function()
	Snacks.git.browse({ what = "file" })
end, { desc = "Open File in Git Web" })

-- Git log for current file
keymap("n", "<leader>gl", function()
	Snacks.git.log({ what = "file" })
end, { desc = "Git Log for File" })

-- ===============================================
-- SNACKS.ANIMATE - Smooth animations
-- ===============================================

-- Animate is automatically enabled and enhances:
-- - Window opening/closing
-- - Cursor movements
-- - Scroll animations
-- - Buffer switches

-- Removed snacks.animate.toggle - animations auto-enabled

-- ===============================================
-- SNACKS.QUICKFILE - Quick file operations
-- ===============================================

-- Quick file operations (complement to Oil)
keymap("n", "<leader>qn", function()
	Snacks.quickfile.new()
end, { desc = "New File" })

keymap("n", "<leader>qd", function()
	Snacks.quickfile.delete()
end, { desc = "Delete File" })

keymap("n", "<leader>qc", function()
	Snacks.quickfile.copy()
end, { desc = "Copy File" })

keymap("n", "<leader>qm", function()
	Snacks.quickfile.move()
end, { desc = "Move File" })

-- ===============================================
-- SNACKS.RENAME - File and symbol renaming
-- ===============================================

-- Rename current file
keymap("n", "<leader>rn", function()
	Snacks.rename.rename_file()
end, { desc = "Rename File" })

-- LSP rename (enhanced)
keymap("n", "<leader>rr", function()
	Snacks.rename.rename()
end, { desc = "LSP Rename" })

-- Rename with preview
keymap("n", "<leader>rp", function()
	Snacks.rename.rename({ preview = true })
end, { desc = "LSP Rename (Preview)" })

-- ===============================================
-- INTEGRATION KEYMAPS
-- ===============================================

-- Zen mode for specific file types (great for writing)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex", "text" },
	callback = function()
		keymap("n", "<leader><leader>", function()
			Snacks.zen({
				toggles = {
					dim = true,
					git_signs = false,
					diagnostics = false,
				},
				show = {
					statusline = false,
					tabline = false,
				},
				win = { width = 100 },
			})
		end, { desc = "Writing Zen Mode", buffer = true })
	end,
})

-- Git integration with existing diffview keymaps
keymap("n", "<leader>gd", function()
	-- Use snacks git if available, fallback to diffview
	local ok, _ = pcall(Snacks.git.diff)
	if not ok then
		vim.cmd("DiffviewOpen")
	end
end, { desc = "Git Diff" })