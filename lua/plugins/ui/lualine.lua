-- Shared configuration constants
local SEPARATORS = {
	round2 = { left = "", right = "" },
	round1 = { left = "", right = "" },
	lines = { left = "┃", right = "┃" },
	empty = { left = "", right = "" },
}

local PRETTY_PATH_PROVIDERS = { default = "base", "toggleterm", "oil", "trouble", "dapui", "minifiles" }

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
			section_separators = { left = "", right = "" },
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
					symbols = { added = " ", modified = " ", removed = " " },
					separator = SEPARATORS.empty,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					update_in_insert = false,
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
		extensions = { "lazy", "mason", "quickfix", "overseer" },
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
