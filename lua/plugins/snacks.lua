local gh = require("utils.gh")

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
	specs = { gh("folke/snacks.nvim") },
	setup = function()
		require("snacks").setup({
			animate = { enabled = true },
			lazygit = { enabled = true },
			input = { enabled = true },
			scope = { enabled = true },
			words = { enabled = true },
			scroll = {
				enabled = true,
				animate = { duration = { step = 20, total = 200 } },
			},
			bufdelete = { enabled = true },
			zen = { enabled = true },
			statuscolumn = {
				enabled = true,
				left = { "mark", "git" },
				right = { "fold", "sign" },
				folds = { git_hl = true },
			},
			git = { enabled = true },
			gh = { enabled = true },
			quickfile = { enabled = true },
			rename = { enabled = true },
			layout = { enabled = true },
			win = { enabled = true },
			bigfile = { enabled = true },
			scratch = { enabled = true },
			gitbrowse = { enabled = true },
			toggle = { enabled = true },
			debug = { enabled = true },
			profiler = { enabled = true },
			styles = { enabled = true },
			indent = {
				only_scope = true,
				filter = function(buf)
					return vim.g.snacks_indent ~= false
						and vim.b[buf].snacks_indent ~= false
						and vim.bo[buf].buftype == ""
						and vim.bo[buf].filetype ~= "haskell"
				end,
			},
			explorer = { enabled = false },
			dim = { enabled = false },
			image = {
				enabled = true,
				resolve = function(path, src)
					local ok, api = pcall(require, "obsidian.api")
					if ok and api.path_is_note(path) then
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
				enabled = false,
				preset = {
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "L", desc = "Plugins", action = ":lua vim.pack.update()" },

						{
							icon = " ",
							key = "G",
							desc = "Lazygit",
							action = ':lua Snacks.lazygit.open({win = { width = 0.8, height = 0.8, border = "rounded" },})',
						},
						{ icon = "󱊍 ", key = "M", desc = "Mason", action = ":Mason" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},

			notifier = {
				enabled = false,
				timeout = 5000,
				style = "compact",
				top_down = false,
				width = { min = 40, max = 80 },
			},

			picker = {
				win = {
					input = {
						border = "rounded",
						wo = { winblend = 0 },
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
					wo = {
						winbar = "",
					},
					bo = {
						filetype = "terminal",
					},
				},
			},
		})

		-- Terminal keymaps
		vim.keymap.set("n", "<leader>tt", function()
			Snacks.terminal.toggle(nil, {
				win = { position = "bottom", height = 10 },
			})
		end, { desc = "Toggle Terminal" })
		vim.keymap.set("n", "<leader>tf", function()
			Snacks.terminal.open(nil, {
				win = { position = "float", width = 0.8, height = 0.8, border = "rounded" },
			})
		end, { desc = "Open Float Terminal" })
		vim.keymap.set("n", "<leader>th", function()
			Snacks.terminal.open(nil, {
				win = { position = "bottom", height = 10 },
			})
		end, { desc = "Open Horizontal Terminal" })
		vim.keymap.set("n", "<leader>tv", function()
			Snacks.terminal.open(nil, {
				win = { position = "right", width = 10 },
			})
		end, { desc = "Open Vertical Terminal" })

		-- Git keymaps
		vim.keymap.set("n", "<leader>gg", function()
			Snacks.lazygit.open({
				win = { width = 0.8, height = 0.8, border = "rounded" },
			})
		end, { desc = "Toggle Lazygit" })
		vim.keymap.set("n", "<leader>go", function()
			Snacks.gitbrowse()
		end, { desc = "Open in Browser" })
		vim.keymap.set("v", "<leader>go", function()
			Snacks.gitbrowse()
		end, { desc = "Open in Browser" })
		vim.keymap.set("n", "<leader>gB", function()
			Snacks.git.blame_line()
		end, { desc = "Git blame line" })
		vim.keymap.set({ "n", "v" }, "<leader>gi", function()
			Snacks.picker.gh_issue()
		end, { desc = "Open GitHub Issues" })

		-- Scratch/notes keymaps
		vim.keymap.set("n", "<leader>ns", function()
			Snacks.scratch()
		end, { desc = "Open Scratch Buffer" })
		vim.keymap.set("n", "<leader>nS", function()
			Snacks.scratch.select()
		end, { desc = "Select Scratch Buffer" })

		-- Toggle keymaps
		vim.keymap.set("n", "<leader>ur", function()
			vim.opt.relativenumber = not vim.opt.relativenumber:get()
		end, { desc = "Toggle Relative Numbers" })
		vim.keymap.set("n", "<leader>uw", function()
			vim.o.wrap = not vim.o.wrap
			local state = vim.o.wrap and "enabled" or "disabled"
			vim.notify("Line wrap " .. state, vim.log.levels.INFO)
		end, { desc = "Toggle Line Wrap" })
		vim.keymap.set("n", "<leader>us", function()
			Snacks.toggle.option("spell")
		end, { desc = "Toggle Spelling" })
		vim.keymap.set("n", "<leader>ud", function()
			Snacks.toggle.diagnostics()
		end, { desc = "Toggle Diagnostics" })
		vim.keymap.set("n", "<leader>ui", function()
			Snacks.toggle.indent()
		end, { desc = "Toggle Indent Guides" })

		-- Zen mode
		vim.keymap.set("n", "<leader>Z", function()
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
		end, { desc = "Toggle Zen Mode (Writing)" })

		-- Finder keymaps
		vim.keymap.set("n", "<leader><space>", function()
			Snacks.picker.smart()
		end, { desc = "Smart Find Files" })
		vim.keymap.set("n", "<leader>:", function()
			Snacks.picker.command_history()
		end, { desc = "Command History" })
		vim.keymap.set("n", "<leader>fn", function()
			Snacks.picker.notifications()
		end, { desc = "Find Notifications" })
		vim.keymap.set("n", "<leader>fb", function()
			Snacks.picker.buffers()
		end, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fc", function()
			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Find Config File" })
		vim.keymap.set("n", "<leader>ff", function()
			Snacks.picker.files()
		end, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", function()
			Snacks.picker.git_files()
		end, { desc = "Find Git Files" })
		vim.keymap.set("n", "<leader>fp", function()
			Snacks.picker.projects()
		end, { desc = "Projects" })
		vim.keymap.set("n", "<leader>fr", function()
			Snacks.picker.recent()
		end, { desc = "Recent" })

		-- Git pickers
		vim.keymap.set("n", "<leader>gb", function()
			Snacks.picker.git_branches()
		end, { desc = "Git Branches" })
		vim.keymap.set("n", "<leader>gl", function()
			Snacks.picker.git_log()
		end, { desc = "Git Log" })
		vim.keymap.set("n", "<leader>gL", function()
			Snacks.picker.git_log_line()
		end, { desc = "Git Log Line" })
		vim.keymap.set("n", "<leader>gs", function()
			Snacks.picker.git_status()
		end, { desc = "Git Status" })
		vim.keymap.set("n", "<leader>gS", function()
			Snacks.picker.git_stash()
		end, { desc = "Git Stash" })
		vim.keymap.set("n", "<leader>gd", function()
			Snacks.picker.git_diff()
		end, { desc = "Git Diff (Hunks)" })
		vim.keymap.set("n", "<leader>gf", function()
			Snacks.picker.git_log_file()
		end, { desc = "Git Log File" })

		-- Search pickers
		vim.keymap.set("n", "<leader>sb", function()
			Snacks.picker.lines()
		end, { desc = "Buffer Lines" })
		vim.keymap.set("n", "<leader>sB", function()
			Snacks.picker.grep_buffers()
		end, { desc = "Grep Open Buffers" })
		vim.keymap.set("n", "<leader>sg", function()
			Snacks.picker.grep()
		end, { desc = "Grep" })
		vim.keymap.set({ "n", "x" }, "<leader>sw", function()
			Snacks.picker.grep_word()
		end, { desc = "Visual selection or word" })
		vim.keymap.set("n", '<leader>"', function()
			Snacks.picker.registers()
		end, { desc = "Registers" })
		vim.keymap.set("n", "<leader>s/", function()
			Snacks.picker.search_history()
		end, { desc = "Search History" })
		vim.keymap.set("n", "<leader>sa", function()
			Snacks.picker.autocmds()
		end, { desc = "Autocmds" })
		vim.keymap.set("n", "<leader>sC", function()
			Snacks.picker.commands()
		end, { desc = "Commands" })
		vim.keymap.set("n", "<leader>sd", function()
			Snacks.picker.diagnostics()
		end, { desc = "Diagnostics" })
		vim.keymap.set("n", "<leader>sD", function()
			Snacks.picker.diagnostics_buffer()
		end, { desc = "Buffer Diagnostics" })
		vim.keymap.set("n", "<leader>sh", function()
			Snacks.picker.help()
		end, { desc = "Help Pages" })
		vim.keymap.set("n", "<leader>sH", function()
			Snacks.picker.highlights()
		end, { desc = "Highlights" })
		vim.keymap.set("n", "<leader>si", function()
			Snacks.picker.icons()
		end, { desc = "Icons" })
		vim.keymap.set("n", "<leader>sj", function()
			Snacks.picker.jumps()
		end, { desc = "Jumps" })
		vim.keymap.set("n", "<leader>sk", function()
			Snacks.picker.keymaps()
		end, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>sl", function()
			Snacks.picker.loclist()
		end, { desc = "Location List" })
		vim.keymap.set("n", "<leader>sm", function()
			Snacks.picker.marks()
		end, { desc = "Marks" })
		vim.keymap.set("n", "<leader>sM", function()
			Snacks.picker.man()
		end, { desc = "Man Pages" })
		vim.keymap.set("n", "<leader>sq", function()
			Snacks.picker.qflist()
		end, { desc = "Quickfix List" })
		vim.keymap.set("n", "<leader>sR", function()
			Snacks.picker.resume()
		end, { desc = "Resume" })
		vim.keymap.set("n", "<leader>su", function()
			Snacks.picker.undo()
		end, { desc = "Undo History" })

		-- UI pickers
		vim.keymap.set("n", "<leader>uC", function()
			Snacks.picker.colorschemes()
		end, { desc = "Colorschemes" })
		vim.keymap.set("n", "<leader>uF", function()
			local filetypes = vim.fn.getcompletion("", "filetype")
			Snacks.picker.select(filetypes, { prompt = "Set filetype" }, function(ft)
				if ft then
					vim.bo.filetype = ft
				end
			end)
		end, { desc = "Set Filetype" })

		-- LSP pickers
		vim.keymap.set("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, { desc = "Goto Definition" })
		vim.keymap.set("n", "gD", function()
			Snacks.picker.lsp_declarations()
		end, { desc = "Goto Declaration" })
		vim.keymap.set("n", "grr", function()
			Snacks.picker.lsp_references()
		end, { desc = "References" })
		vim.keymap.set("n", "gI", function()
			Snacks.picker.lsp_implementations()
		end, { desc = "Goto Implementation" })
		vim.keymap.set("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, { desc = "Goto T[y]pe Definition" })
		vim.keymap.set("n", "gai", function()
			Snacks.picker.lsp_incoming_calls()
		end, { desc = "C[a]lls Incoming" })
		vim.keymap.set("n", "gao", function()
			Snacks.picker.lsp_outgoing_calls()
		end, { desc = "C[a]lls Outgoing" })
		vim.keymap.set("n", "<leader>ss", function()
			Snacks.picker.lsp_symbols()
		end, { desc = "LSP Symbols" })
		vim.keymap.set("n", "<leader>sS", function()
			Snacks.picker.lsp_workspace_symbols()
		end, { desc = "LSP Workspace Symbols" })

		-- Misc keymaps
		vim.keymap.set("n", "<leader>fz", function()
			Snacks.picker.zoxide()
		end, { desc = "Zoxide" })
		vim.keymap.set("n", "<leader>oO", open_obsidian_tasks_picker, { desc = "Obsidian Tasks (by date)" })
		vim.keymap.set("n", "<leader>fR", function()
			Snacks.rename.rename_file()
		end, { desc = "Rename File" })

		-- Window keymaps
		vim.keymap.set("n", "<leader>wm", function()
			vim.cmd("only")
		end, { desc = "Maximize Window" })
		vim.keymap.set("n", "<leader>wf", function()
			Snacks.win({
				position = "float",
				width = 0.8,
				height = 0.8,
				border = "rounded",
				buf = vim.api.nvim_get_current_buf(),
			})
		end, { desc = "Float Current Buffer" })
		vim.keymap.set("n", "<leader>ws", function()
			Snacks.win({
				position = "bottom",
				height = 0.3,
				buf = vim.api.nvim_get_current_buf(),
			})
		end, { desc = "Split Horizontal" })
		vim.keymap.set("n", "<leader>wS", function()
			Snacks.win({
				position = "right",
				width = 0.5,
				buf = vim.api.nvim_get_current_buf(),
			})
		end, { desc = "Split Vertical" })
	end,
}
