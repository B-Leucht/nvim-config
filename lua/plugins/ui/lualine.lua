-- Shared configuration constants
local SEPARATORS = {
	round2 = { left = "\u{e0b4}", right = "\u{e0b6}" },
	round1 = { left = "\u{e0b6}", right = "\u{e0b4}" },
	lines = { left = "┃", right = "┃" },
	empty = { left = "", right = "" },
}

-- Custom extensions
local extensions = {
	lazy = {
		sections = {
			lualine_a = { { function() return "󰒲 Lazy" end, separator = SEPARATORS.round1 } },
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "lazy" },
	},
	mason = {
		sections = {
			lualine_a = { { function() return " Mason" end, separator = SEPARATORS.round1 } },
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "mason" },
	},
}

local PRETTY_PATH_PROVIDERS = {
	default = "base",
	"toggleterm",
	"oil",
	"trouble",
	"dapui",
	"minifiles",
	"snacks_scratch",
	"snacks_terminal",
	"snacks_explorer",
	"snacks_picker",
}

local DISABLED_FILETYPES = {
	statusline = { "snacks_dashboard" }, -- Disable statusline in Oil to prevent git process spam
	winbar = {
		"lazy",
		"mason",
		"help",
		"qf",
		"quickfix",
		"snacks_dashboard",
		"nvim-dap-view",
		"dap-view",
		"dap-view-term",
		"dap-repl",
		"terminal",
		"oil",
		"oil_preview",
		"minifiles",
	},
	tabline = { "snacks_dashboard" },
}

local TABLINE_CONFIG = {
	lualine_a = {
		{
			"buffers",
			mode = 2,
			use_mode_colors = true,
			icons_enabled = true,
			separator = SEPARATORS.round1,
			component_separators = { left = "┃", right = "┃" },
			show_filename_only = true,
			show_modified_status = true,
			max_length = function()
				return vim.o.columns -- Use full screen width
			end,
			symbols = { modified = "_󰷥", alternate_file = "", directory = " " },
			filetype_names = {
				oil = "",
				minifiles = "",
				trouble = "Trouble",
				lazy = "Lazy",
				mason = "Mason",
				snacks_picker_input = "",
				snacks_picker_list = "󰙅",
				snacks_picker_preview = "",
				snacks_dashboard = "󰕮",
			},
			buffers_color = { active = "lualine_a_normal", inactive = "lualine_b_normal" },
		},
	},
	lualine_z = {},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "folke/noice.nvim", "cameronr/lualine-pretty-path" }, -- mini.icons mocks nvim-web-devicons
	event = "VeryLazy",
	init = function()
		vim.g.lualine_minimal = true
		vim.opt.showtabline = 0 -- Hide tabline by default
	end,
	opts = {
		options = {
			theme = require("core.constants").APPEARANCE.THEME,
			component_separators = { left = "", right = "" },
			section_separators = SEPARATORS.round1,
			globalstatus = true,
			disabled_filetypes = DISABLED_FILETYPES,
			always_divide_middle = true,
			refresh = { statusline = 2000, tabline = 5000, winbar = 5000 },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					separator = SEPARATORS.round1,
					fmt = function(str)
						local mode_map = {
							NORMAL = "N",
							INSERT = "I",
							VISUAL = "V",
							["V-LINE"] = "VL",
							["V-BLOCK"] = "VB",
							COMMAND = "C",
							REPLACE = "R",
							SELECT = "S",
							TERMINAL = "T",
						}
						return mode_map[str] or str:sub(1, 1)
					end,
				},
			},
			lualine_b = {
				{ "pretty_path", providers = PRETTY_PATH_PROVIDERS, section_separators = SEPARATORS.round2 },
			},
			lualine_c = {
				{ "branch", separator = SEPARATORS.empty },
				{
					"diff",
					symbols = { added = "", modified = "", removed = "" },
					separator = SEPARATORS.empty,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = { error = "", warn = "", info = "", hint = "" },
					update_in_insert = false,
					separator = SEPARATORS.empty,
				},
				-- Overseer Tasks
				{
					function()
						local ok, overseer = pcall(require, "overseer")
						if not ok then
							return ""
						end
						local tasks = overseer.list_tasks({ recent_first = true })
						local running = 0
						local success = 0
						local failure = 0
						for _, task in ipairs(tasks) do
							if task.status == "RUNNING" then
								running = running + 1
							elseif task.status == "SUCCESS" then
								success = success + 1
							elseif task.status == "FAILURE" then
								failure = failure + 1
							end
						end
						if running > 0 then
							return "󰑮 " .. running
						elseif failure > 0 then
							return "󰅚 " .. failure
						elseif success > 0 then
							return "󰄴 " .. success
						end
						return ""
					end,
					cond = function()
						local ok, overseer = pcall(require, "overseer")
						if not ok then
							return false
						end
						local tasks = overseer.list_tasks({ recent_first = true })
						return #tasks > 0
					end,
					color = function()
						local ok, overseer = pcall(require, "overseer")
						if not ok then
							return { fg = "#6c7086" }
						end
						local tasks = overseer.list_tasks({ recent_first = true })
						for _, task in ipairs(tasks) do
							if task.status == "RUNNING" then
								return { fg = "#f9e2af" } -- Yellow for running
							elseif task.status == "FAILURE" then
								return { fg = "#f38ba8" } -- Red for failure
							end
						end
						return { fg = "#a6e3a1" } -- Green for success
					end,
					separator = SEPARATORS.empty,
				},
				-- Molten Kernel Status
				{
					function()
						-- Check if molten is available via vim variable
						if vim.g.molten_initialized then
							-- Try to get kernel info from buffer variable
							local kernel = vim.b.molten_kernel_name
							if kernel and kernel ~= "" then
								return "󱘖 " .. kernel
							end
							-- Fallback: just show that molten is active
							return "󱘖"
						end
						return ""
					end,
					cond = function()
						return vim.g.molten_initialized == 1
					end,
					color = { fg = "#89b4fa" }, -- Blue
					separator = SEPARATORS.empty,
				},
				{
					function()
						local ok, noice = pcall(require, "noice")
						return ok and noice.api.status.search.get() or ""
					end,
					cond = function()
						local ok, noice = pcall(require, "noice")
						return ok and noice.api.status.search.has()
					end,
					color = { fg = "#ff9e64" },
					separator = SEPARATORS.empty,
				},
				{
					"selectioncount",
					fmt = function(str)
						return str ~= "" and "󰒅 " .. str or ""
					end,
					separator = SEPARATORS.empty,
				},
				{
					function()
						local ok, lazy = pcall(require, "lazy.status")
						return ok and lazy.updates() or ""
					end,
					cond = function()
						local ok, lazy = pcall(require, "lazy.status")
						return ok and lazy.has_updates()
					end,
					color = { fg = "#ff9e64" },
					separator = SEPARATORS.empty,
				},
			},
			lualine_y = { { "progress", section_separators = SEPARATORS.round2 } },
			lualine_z = {
				{
					"location",
					icon = "",
					separator = SEPARATORS.round1,
				},
			},
		},
		inactive_sections = {
			lualine_c = { { "pretty_path", providers = PRETTY_PATH_PROVIDERS } },
			lualine_x = { "location" },
		},
		tabline = {},
		extensions = {
			extensions.lazy,
			extensions.mason,
			"quickfix",
			"overseer",
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
	keys = {
		{
			"<leader>ul",
			function()
				vim.g.lualine_minimal = not vim.g.lualine_minimal
				local opts = require("lazy.core.plugin").values(
					require("lazy.core.config").spec.plugins["lualine.nvim"],
					"opts",
					false
				)
				opts.tabline = vim.g.lualine_minimal and {} or vim.deepcopy(TABLINE_CONFIG)
				vim.opt.showtabline = vim.g.lualine_minimal and 0 or 2
				require("lualine").setup(opts)
				vim.cmd("redrawtabline")
				vim.cmd("redrawstatus!")
			end,
			desc = "Toggle Tabline",
		},
	},
}
