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
	config = function(_, opts)
		local Snacks = require("snacks")
		vim.api.nvim_set_hl(0, "SnacksImageMath", { fg = "#cdd6f4" })
		Snacks.setup(opts)
		if Snacks.dashboard and Snacks.dashboard.sections then
			Snacks.dashboard.sections.obsidian_tasks = function(item)
				return function(self)
					local limit = item.limit or 10
					local height = item.height or 10
					local width = item.width or (self.opts.width - (item.indent or 0))
					local vault = item.cwd or os.getenv("OBSIDIAN_VAULT")
					local tasks = require("utils.obsidian").fetch_tasks(vault)
					local lines = {}
					for i, task in ipairs(tasks) do
						if i > limit then
							break
						end
						table.insert(lines, task.text .. " [[" .. task.filename .. "]]")
					end

					if #lines == 0 then
						return {}
					end

					-- Fake path so obsidian.nvim attaches
					local buf = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_buf_set_name(buf, vault .. "/.dashboard-tasks.md")
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
					vim.bo[buf].filetype = "markdown"
					vim.bo[buf].buftype = "nofile"
					vim.bo[buf].modifiable = false

					vim.keymap.set(
						"n",
						"t",
						open_obsidian_tasks_picker,
						{ buffer = self.buf, desc = "Open task picker" }
					)

					local win ---@type integer?

					return {
						{
							text = string.rep("\n", height),
							render = function(_, pos)
								win = vim.api.nvim_open_win(buf, false, {
									bufpos = { pos[1] - 1, pos[2] + 1 },
									col = item.indent or 0,
									focusable = true,
									height = height,
									noautocmd = true,
									relative = "win",
									row = 0,
									zindex = Snacks.config.styles.dashboard.zindex + 1,
									style = "minimal",
									width = width,
									win = self.win,
									border = "none",
								})
								vim.schedule(function()
									if win and vim.api.nvim_win_is_valid(win) then
										vim.api.nvim_win_call(win, function()
											vim.cmd("doautocmd BufEnter")
										end)
									end
								end)
								vim.api.nvim_create_autocmd("BufWipeout", {
									buffer = self.buf,
									once = true,
									callback = function()
										pcall(vim.api.nvim_win_close, win, true)
										pcall(vim.api.nvim_buf_delete, buf, { force = true })
									end,
								})
							end,
						},
					}
				end
			end
		end
	end,
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
			"<leader>py",
			function()
				Snacks.terminal.toggle("ipython", {
					win = { position = "float", width = 0.8, height = 0.8 },
				})
			end,
			desc = "Toggle IPython Terminal",
		},
		{
			"<leader>ss",
			function()
				Snacks.terminal.open("ssh", {
					win = { position = "bottom", height = 10 },
				})
			end,
			desc = "Open SSH Terminal",
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
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
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
			"<leader>rn",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>lr",
			function()
				Snacks.rename.rename()
			end,
			desc = "Rename",
		},
		{
			"<leader>lp",
			function()
				Snacks.rename.rename({ preview = true })
			end,
			desc = "Rename (Preview)",
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
		indent = { enabled = true },
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
			preset = {
				header = [[


]],
			},

			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{
					icon = " ",
					title = "Tasks",
					section = "obsidian_tasks",
					enabled = function()
						local cwd = vim.fn.getcwd()
						return cwd:find("obsidian") ~= nil or cwd:find("Vault") ~= nil
					end,
					limit = 10,
					height = 10,
					indent = 2,
					padding = 1,
				},
				{ section = "startup" },
			},
			keys = {
				{ icon = "", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
				{ icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
				{ icon = "", key = "g", desc = "Live Grep", action = ":lua Snacks.picker.grep()" },
				{ icon = "", key = "b", desc = "Bookmarks", action = ":lua Snacks.picker.marks()" },
				{
					icon = "󰦛",
					key = "s",
					desc = "Restore Session",
					action = ":lua MiniSessions.read(MiniSessions.get_latest())",
				},
				{
					icon = "",
					key = "c",
					desc = "Configuration",
					action = ":e " .. vim.fn.stdpath("config") .. "/init.lua",
				},
				{ icon = "󰒲", key = "l", desc = "Lazy", action = ":Lazy" },
				{ icon = "", key = "q", desc = "Quit", action = ":qa" },
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
