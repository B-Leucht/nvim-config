local function open_obsidian_tasks_picker()
	local Snacks = require("snacks")
	local tasks = require("utils.obsidian").fetch_tasks()
	local picker_items = {}
	for _, task in ipairs(tasks) do
		table.insert(picker_items, { text = task.text, file = task.file, pos = { task.lnum, 0 } })
	end
	Snacks.picker({
		title = "Obsidian Tasks (by date)",
		items = picker_items,
		format = function(item)
			return { { item.text, "Normal" } }
		end,
	})
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>tt",
			function()
				Snacks.terminal.toggle(nil, {
					win = { position = "bottom", height = 10 },
				})
			end,
			desc = "Toggle Terminal",
		},
		{
			"<leader>tf",
			function()
				Snacks.terminal.open(nil, {
					win = { position = "float", width = 0.8, height = 0.8 },
				})
			end,
			desc = "Open Float Terminal",
		},
		{
			"<leader>th",
			function()
				Snacks.terminal.open(nil, {
					win = { position = "bottom", height = 10 },
				})
			end,
			desc = "Open Horizontal Terminal",
		},
		{
			"<leader>tv",
			function()
				Snacks.terminal.open(nil, {
					win = { position = "right", width = 10 },
				})
			end,
			desc = "Open Vertical Terminal",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit.open({
					win = { width = 0.8, height = 0.8 },
				})
			end,
			desc = "Toggle Lazygit",
		},

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

		{
			"<leader>go",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Open in Browser",
			mode = { "n", "v" },
		},

		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "Open GitHub Issues",
			mode = { "n", "v" },
		},

		{
			"<leader>ur",
			function()
				vim.opt.relativenumber = not vim.opt.relativenumber:get()
			end,
			desc = "Toggle Relative Numbers",
		},
		{
			"<leader>uw",
			function()
				vim.o.wrap = not vim.o.wrap
				local state = vim.o.wrap and "enabled" or "disabled"
				vim.notify("Line wrap " .. state, vim.log.levels.INFO)
			end,
			desc = "Toggle Line Wrap",
		},
		{
			"<leader>us",
			function()
				Snacks.toggle.option("spell")
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
		{
			"<leader>un",
			function()
				vim.g.custom_lualine_show_names = not vim.g.custom_lualine_show_names
				-- Force lualine refresh with error handling
				vim.schedule(function()
					local ok, lualine = pcall(require, "lualine")
					if ok then
						lualine.refresh()
					end
				end)
				local status = vim.g.custom_lualine_show_names and "shown" or "hidden"
				vim.notify("Lualine names " .. status, vim.log.levels.INFO)
			end,
			desc = "Toggle Lualine Names",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen({
					toggles = {
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
			"<leader>fn",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Find Notifications",
		},
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
		{
			'<leader>"',
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
		{
			"<leader>fz",
			function()
				Snacks.picker.zoxide()
			end,
			desc = "Zoxide",
		},

		{
			"<leader>oO",
			open_obsidian_tasks_picker,
			desc = "Obsidian Tasks (by date)",
		},

		{
			"<leader>fR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>lr",
			function()
				vim.lsp.buf.rename()
			end,
			desc = "Rename",
		},

		{
			"<leader>wm",
			function()
				vim.cmd("only")
			end,
			desc = "Maximize Window",
		},
		{
			"<leader>wf",
			function()
				Snacks.win({
					position = "float",
					width = 0.8,
					height = 0.8,
					border = "rounded",
					buf = vim.api.nvim_get_current_buf(),
				})
			end,
			desc = "Float Current Buffer",
		},
		{
			"<leader>ws",
			function()
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
				Snacks.win({
					position = "right",
					width = 0.5,
					buf = vim.api.nvim_get_current_buf(),
				})
			end,
			desc = "Split Vertical",
		},
	},
	opts = {
		lazygit = { enabled = true },
		input = { enabled = true },
		scope = { enabled = true },
		words = { enabled = true },
		scroll = { enabled = true },
		bufdelete = { enabled = true },
		indent = {
			enabled = true,
			only_scope = true,
			filter = function(buf, win)
				return vim.g.snacks_indent ~= false
					and vim.b[buf].snacks_indent ~= false
					and vim.bo[buf].buftype == ""
					and vim.bo[buf].filetype ~= "haskell"
			end,
		},
		zen = { enabled = true },
		statuscolumn = { enabled = true },
		git = { enabled = true },
		gh = { enabled = true },
		animate = { enabled = true },
		quickfile = { enabled = true },
		rename = { enabled = true },
		layout = { enabled = true },
		win = { enabled = true },
		bigfile = { enabled = true },
		explorer = { enabled = false },
		scratch = { enabled = true },
		gitbrowse = { enabled = true },
		toggle = { enabled = true },
		debug = { enabled = true },
		dim = { enabled = false },
		profiler = { enabled = true },
		styles = { enabled = true },
		image = {
			enabled = true,
			resolve = function(path, src)
				local api = require("obsidian.api")
				if api.path_is_note(path) then
					return api.resolve_attachment_path(src)
				end
			end,
			doc = {
				enabled = true,
				inline = true,
				float = true,
				max_width = 80,
				max_height = 40,
			},
			math = {
				enabled = true,
				typst = {},
				latex = {
					font_size = "small",
					dpi = 300,
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools", "lmodern" },
				},
			},
		},

		dashboard = {
			enabled = true,
			preset = { header = {} },
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},

		notifier = {
			enabled = true,
			timeout = 5000,
			style = "compact",
			top_down = false,
			width = { min = 40, max = 80 },
		},

		picker = {
			layout = "default",
			enabled = true,
			actions = {
				sidekick_send = function(...)
					return require("sidekick.cli.picker.snacks").send(...)
				end,
			},
			win = {
				input = {
					border = "rounded",
					wo = { winblend = 0 },
					keys = {
						["<a-a>"] = {
							"sidekick_send",
							mode = { "n", "i" },
						},
					},
				},
				list = {
					border = "rounded",
					wo = { winblend = 0 },
				},
				preview = {
					border = "rounded",
					wo = { winblend = 0 },
				},
			},
		},

		terminal = {
			enabled = true,
			win = {
				border = "rounded",
				wo = {
					winbar = "",
					winblend = 0,
				},
			},
			bo = {
				filetype = "terminal",
			},
		},
	},
}
