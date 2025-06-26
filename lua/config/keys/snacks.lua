-- Snacks keymaps
local constants = require("core.constants")

return {
	-- Terminal keymaps
	{ "<leader>tt", function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
			if ft == "trouble" then
				vim.api.nvim_win_close(win, false)
				return
			end
		end
		Snacks.terminal.toggle(nil, {
			win = { position = "bottom", height = constants.UI.PANEL_HEIGHT },
			interactive = true,
		})
	end, desc = "Toggle Terminal" },
	{ "<leader>tf", function() 
		Snacks.terminal.open(nil, {
			win = { position = "float", width = constants.UI.WINDOW_SCALE, height = constants.UI.WINDOW_SCALE },
			interactive = true,
		}) 
	end, desc = "Toggle Float Terminal" },
	{ "<leader>th", function() 
		Snacks.terminal.open(nil, {
			win = { position = "bottom", height = constants.UI.PANEL_HEIGHT },
			interactive = true,
		}) 
	end, desc = "Toggle Horizontal Terminal" },
	{ "<leader>tv", function() 
		Snacks.terminal.open(nil, {
			win = { position = "right", width = constants.UI.SIDEBAR_WIDTH },
			interactive = true,
		}) 
	end, desc = "Toggle Vertical Terminal" },
	{ "<leader>py", function() 
		Snacks.terminal("ipython", {
			win = { position = "float", width = constants.UI.WINDOW_SCALE, height = constants.UI.WINDOW_SCALE },
			interactive = true,
		}) 
	end, desc = "New IPython Terminal" },
	{ "<leader>ss", function() 
		Snacks.terminal("ssh", {
			win = { position = "bottom", height = constants.UI.PANEL_HEIGHT },
			interactive = true,
		}) 
	end, desc = "New SSH Terminal" },

	-- Lazygit
	{ "<leader>gg", function() Snacks.lazygit.open() end, desc = "Toggle Lazygit" },

	-- Zen mode
	{ "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
	{ "<leader>Z", function() 
		Snacks.zen({
			toggles = { dim = true, git_signs = false, mini_diff_signs = false, diagnostics = false, inlay_hints = false },
			show = { statusline = false, tabline = false },
			win = { width = 120 },
		}) 
	end, desc = "Toggle Zen Mode (Writing)" },

	-- Git operations
	{ "<leader>gbl", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
	{ "<leader>gbf", function() Snacks.git.blame_file() end, desc = "Git Blame File" },
	{ "<leader>gR", function() Snacks.git.browse() end, desc = "Browse Git Repository" },
	{ "<leader>gO", function() Snacks.git.browse({ what = "file" }) end, desc = "Open File in Git Web" },
	{ "<leader>gfl", function() Snacks.git.log({ what = "file" }) end, desc = "Git Log for File" },

	-- Picker keymaps
	{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
	{ "<leader>fF", function() Snacks.picker.git_files() end, desc = "Find git files" },
	{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
	{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
	{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Live grep" },
	{ "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor" },
	{ "<leader>fW", function() Snacks.picker.grep_word({ word_match = false }) end, desc = "Grep WORD under cursor" },
	{ "<leader>fg", function() Snacks.picker.grep_selection() end, desc = "Grep selection", mode = "v" },
	{ "<leader>ft", function() Snacks.picker.grep({ search = "TODO|FIXME|HACK|WARN|PERF|NOTE" }) end, desc = "Find todos" },
	{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help tags" },
	{ "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
	{ "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
	{ "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
	{ "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
	{ "<leader>fz", function() Snacks.picker.resume() end, desc = "Resume last search" },

	-- Quickfile operations
	{ "<leader>qn", function() Snacks.quickfile.new() end, desc = "New File" },
	{ "<leader>qd", function() Snacks.quickfile.delete() end, desc = "Delete File" },
	{ "<leader>qc", function() Snacks.quickfile.copy() end, desc = "Copy File" },
	{ "<leader>qm", function() Snacks.quickfile.move() end, desc = "Move File" },

	-- Rename operations
	{ "<leader>rn", function() Snacks.rename.rename_file() end, desc = "Rename File" },
	{ "<leader>rr", function() Snacks.rename.rename() end, desc = "LSP Rename" },
	{ "<leader>rp", function() Snacks.rename.rename({ preview = true }) end, desc = "LSP Rename (Preview)" },
}