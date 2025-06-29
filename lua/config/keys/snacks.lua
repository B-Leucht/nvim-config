-- Snacks keymaps
local constants = require("core.constants")

return {
	-- Terminal keymaps
	{
		"<leader>tt",
		function()
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
		end,
		desc = "Toggle Terminal",
	},
	{
		"<leader>tf",
		function()
			Snacks.terminal.open(nil, {
				win = { position = "float", width = constants.UI.WINDOW_SCALE, height = constants.UI.WINDOW_SCALE },
				interactive = true,
			})
		end,
		desc = "Toggle Float Terminal",
	},
	{
		"<leader>th",
		function()
			Snacks.terminal.open(nil, {
				win = { position = "bottom", height = constants.UI.PANEL_HEIGHT },
				interactive = true,
			})
		end,
		desc = "Toggle Horizontal Terminal",
	},
	{
		"<leader>tv",
		function()
			Snacks.terminal.open(nil, {
				win = { position = "right", width = constants.UI.SIDEBAR_WIDTH },
				interactive = true,
			})
		end,
		desc = "Toggle Vertical Terminal",
	},
	{
		"<leader>py",
		function()
			Snacks.terminal("ipython", {
				win = { position = "float", width = constants.UI.WINDOW_SCALE, height = constants.UI.WINDOW_SCALE },
				interactive = true,
			})
		end,
		desc = "New IPython Terminal",
	},
	{
		"<leader>ss",
		function()
			Snacks.terminal("ssh", {
				win = { position = "bottom", height = constants.UI.PANEL_HEIGHT },
				interactive = true,
			})
		end,
		desc = "New SSH Terminal",
	},

	-- Lazygit
	{
		"<leader>gg",
		function()
			Snacks.lazygit.open({
				win = { width = constants.UI.WINDOW_SCALE, height = constants.UI.WINDOW_SCALE },
			})
		end,
		desc = "Toggle Lazygit",
	},

	-- File Explorer
	{
		"<leader>e",
		function()
			Snacks.explorer()
		end,
		desc = "Toggle Explorer",
	},

	-- Scratch buffer
	{
		"<leader>ns",
		function()
			Snacks.scratch()
		end,
		desc = "Open Scratch Buffer",
	},
	{
		"<leader>nS",
		function()
			Snacks.scratch.select()
		end,
		desc = "Select Scratch Buffer",
	},

	-- Git browse
	{
		"<leader>go",
		function()
			Snacks.gitbrowse()
		end,
		desc = "Open in Browser",
		mode = { "n", "v" },
	},

	-- Toggle utilities
	{
		"<leader>ul",
		function()
			Snacks.toggle.line_number()
		end,
		desc = "Toggle Line Numbers",
	},
	{
		"<leader>ur",
		function()
			Snacks.toggle.relativenumber()
		end,
		desc = "Toggle Relative Numbers",
	},
	{
		"<leader>uw",
		function()
			Snacks.toggle.wrap()
		end,
		desc = "Toggle Line Wrap",
	},
	{
		"<leader>us",
		function()
			Snacks.toggle.spell()
		end,
		desc = "Toggle Spelling",
	},
	{
		"<leader>ud",
		function()
			Snacks.toggle.diagnostics()
		end,
		desc = "Toggle Diagnostics",
	},
	{
		"<leader>ui",
		function()
			Snacks.toggle.indent()
		end,
		desc = "Toggle Indent Guides",
	},

	-- Zen mode
	{
		"<leader>z",
		function()
			Snacks.zen()
		end,
		desc = "Toggle Zen Mode",
	},
	{
		"<leader>Z",
		function()
			Snacks.zen({
				toggles = {
					dim = true,
					git_signs = false,
					mini_diff_signs = false,
					diagnostics = false,
					inlay_hints = false,
				},
				show = { statusline = false, tabline = false },
				win = { width = 120 },
			})
		end,
		desc = "Toggle Zen Mode (Writing)",
	},

	-- Git operations
	{
		"<leader>gbl",
		function()
			Snacks.git.blame_line()
		end,
		desc = "Git Blame Line",
	},
	{
		"<leader>gbf",
		function()
			Snacks.git.blame_file()
		end,
		desc = "Git Blame File",
	},
	{
		"<leader>gR",
		function()
			Snacks.git.browse()
		end,
		desc = "Browse Git Repository",
	},
	{
		"<leader>gO",
		function()
			Snacks.git.browse({ what = "file" })
		end,
		desc = "Open File in Git Web",
	},
	{
		"<leader>gfl",
		function()
			Snacks.git.log({ what = "file" })
		end,
		desc = "Git Log for File",
	},

	-- Picker keymaps
	-- Top Pickers & Explorer
	{
		"<leader><space>",
		function()
			Snacks.picker.smart()
		end,
		desc = "Smart Find Files",
	},
	{
		"<leader>:",
		function()
			Snacks.picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>n",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
	{
		"<leader>e",
		function()
			Snacks.explorer()
		end,
		desc = "File Explorer",
	},
	-- find
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>fc",
		function()
			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find Config File",
	},
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fg",
		function()
			Snacks.picker.git_files()
		end,
		desc = "Find Git Files",
	},
	{
		"<leader>fp",
		function()
			Snacks.picker.projects()
		end,
		desc = "Projects",
	},
	{
		"<leader>fr",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent",
	},
	-- git
	{
		"<leader>gb",
		function()
			Snacks.picker.git_branches()
		end,
		desc = "Git Branches",
	},
	{
		"<leader>gl",
		function()
			Snacks.picker.git_log()
		end,
		desc = "Git Log",
	},
	{
		"<leader>gL",
		function()
			Snacks.picker.git_log_line()
		end,
		desc = "Git Log Line",
	},
	{
		"<leader>gs",
		function()
			Snacks.picker.git_status()
		end,
		desc = "Git Status",
	},
	{
		"<leader>gS",
		function()
			Snacks.picker.git_stash()
		end,
		desc = "Git Stash",
	},
	{
		"<leader>gd",
		function()
			Snacks.picker.git_diff()
		end,
		desc = "Git Diff (Hunks)",
	},
	{
		"<leader>gf",
		function()
			Snacks.picker.git_log_file()
		end,
		desc = "Git Log File",
	},
	-- Grep
	{
		"<leader>sb",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<leader>sB",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "Grep Open Buffers",
	},
	{
		"<leader>sg",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>sw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	-- search
	{
		'<leader>s"',
		function()
			Snacks.picker.registers()
		end,
		desc = "Registers",
	},
	{
		"<leader>s/",
		function()
			Snacks.picker.search_history()
		end,
		desc = "Search History",
	},
	{
		"<leader>sa",
		function()
			Snacks.picker.autocmds()
		end,
		desc = "Autocmds",
	},
	{
		"<leader>sb",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<leader>sc",
		function()
			Snacks.picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>sC",
		function()
			Snacks.picker.commands()
		end,
		desc = "Commands",
	},
	{
		"<leader>sd",
		function()
			Snacks.picker.diagnostics()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>sD",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>sh",
		function()
			Snacks.picker.help()
		end,
		desc = "Help Pages",
	},
	{
		"<leader>sH",
		function()
			Snacks.picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>si",
		function()
			Snacks.picker.icons()
		end,
		desc = "Icons",
	},
	{
		"<leader>sj",
		function()
			Snacks.picker.jumps()
		end,
		desc = "Jumps",
	},
	{
		"<leader>sk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Keymaps",
	},
	{
		"<leader>sl",
		function()
			Snacks.picker.loclist()
		end,
		desc = "Location List",
	},
	{
		"<leader>sm",
		function()
			Snacks.picker.marks()
		end,
		desc = "Marks",
	},
	{
		"<leader>sM",
		function()
			Snacks.picker.man()
		end,
		desc = "Man Pages",
	},
	{
		"<leader>sp",
		function()
			Snacks.picker.lazy()
		end,
		desc = "Search for Plugin Spec",
	},
	{
		"<leader>sq",
		function()
			Snacks.picker.qflist()
		end,
		desc = "Quickfix List",
	},
	{
		"<leader>sR",
		function()
			Snacks.picker.resume()
		end,
		desc = "Resume",
	},
	{
		"<leader>su",
		function()
			Snacks.picker.undo()
		end,
		desc = "Undo History",
	},
	{
		"<leader>uC",
		function()
			Snacks.picker.colorschemes()
		end,
		desc = "Colorschemes",
	},
	-- LSP
	{
		"gd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"gD",
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"gr",
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"gI",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"gy",
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto T[y]pe Definition",
	},
	{
		"<leader>ss",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"<leader>sS",
		function()
			Snacks.picker.lsp_workspace_symbols()
		end,
		desc = "LSP Workspace Symbols",
	},
	-- folke/todo-comments.nvim integration
	{
		"<leader>st",
		function()
			Snacks.picker.todo_comments()
		end,
		desc = "Todo Comments",
	},
	{
		"<leader>sT",
		function()
			Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
		end,
		desc = "Todo/Fix/Fixme Comments",
	},
	-- Zoxide
	{
		"<leader>fz",
		function()
			Snacks.picker.zoxide()
		end,
		desc = "Zoxide",
	},

	-- Quickfile operations
	{
		"<leader>qn",
		function()
			Snacks.quickfile.new()
		end,
		desc = "New File",
	},
	{
		"<leader>qd",
		function()
			Snacks.quickfile.delete()
		end,
		desc = "Delete File",
	},
	{
		"<leader>qc",
		function()
			Snacks.quickfile.copy()
		end,
		desc = "Copy File",
	},
	{
		"<leader>qm",
		function()
			Snacks.quickfile.move()
		end,
		desc = "Move File",
	},

	-- Rename operations
	{
		"<leader>rn",
		function()
			Snacks.rename.rename_file()
		end,
		desc = "Rename File",
	},
	{
		"<leader>rr",
		function()
			Snacks.rename.rename()
		end,
		desc = "LSP Rename",
	},
	{
		"<leader>rp",
		function()
			Snacks.rename.rename({ preview = true })
		end,
		desc = "LSP Rename (Preview)",
	},

	-- Layout management
	{
		"<leader>wl",
		function()
			-- Create a simple two-pane layout
			local layout = Snacks.layout.new({
				{ "top", height = 0.5 },
				{ "bottom", height = 0.5 },
			})
			layout:toggle()
		end,
		desc = "Toggle Horizontal Layout",
	},
	{
		"<leader>wv",
		function()
			-- Create a simple vertical split layout
			local layout = Snacks.layout.new({
				{ "left", width = 0.5 },
				{ "right", width = 0.5 },
			})
			layout:toggle()
		end,
		desc = "Toggle Vertical Layout",
	},
	{
		"<leader>wm",
		function()
			-- Maximize current window
			vim.cmd("only")
		end,
		desc = "Maximize Window",
	},
	{
		"<leader>wf",
		function()
			-- Create floating window with current buffer
			Snacks.win({
				position = "float",
				width = constants.UI.WINDOW_SCALE,
				height = constants.UI.WINDOW_SCALE,
				buf = vim.api.nvim_get_current_buf(),
			})
		end,
		desc = "Float Current Buffer",
	},
	{
		"<leader>ws",
		function()
			-- Split current buffer horizontally
			Snacks.win({
				position = "bottom",
				height = 0.3,
				buf = vim.api.nvim_get_current_buf(),
			})
		end,
		desc = "Split Horizontal",
	},
	{
		"<leader>wS",
		function()
			-- Split current buffer vertically using Snacks win
			Snacks.win({
				position = "right",
				width = 0.5,
				buf = vim.api.nvim_get_current_buf(),
			})
		end,
		desc = "Split Vertical",
	},

	-- Search and Replace with grug-far integration
	{
		"<leader>sr",
		function()
			local grug = require("grug-far")
			local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
			grug.open({
				transient = true,
				prefills = {
					filesFilter = ext and ext ~= "" and "*." .. ext or nil,
				},
			})
		end,
		desc = "Search and Replace",
		mode = { "n", "v" },
	},
	{
		"<leader>sR",
		function()
			local grug = require("grug-far")
			local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
			grug.open({
				transient = true,
				prefills = {
					paths = vim.fn.expand("%"),
					filesFilter = ext and ext ~= "" and "*." .. ext or nil,
				},
			})
		end,
		desc = "Search and Replace (current file)",
		mode = { "n", "v" },
	},
}
