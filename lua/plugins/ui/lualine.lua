local SEPARATORS = {
	round2 = { left = "\u{e0b4}", right = "\u{e0b6}" },
	round1 = { left = "\u{e0b6}", right = "\u{e0b4}" },
	lines = { left = "┃", right = "┃" },
	empty = { left = "", right = "" },
}

local cached_palette = nil
local function get_palette()
	if not cached_palette then
		cached_palette = require("catppuccin.palettes").get_palette()
	end
	return cached_palette
end

local extensions = {
	lazy = {
		sections = {
			lualine_a = { {
				function()
					return "󰒲 Lazy"
				end,
				separator = SEPARATORS.round1,
			} },
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "lazy" },
	},
	mason = {
		sections = {
			lualine_a = { {
				function()
					return " Mason"
				end,
				separator = SEPARATORS.round1,
			} },
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "mason" },
	},
	quickfix = {
		sections = {
			lualine_a = {
				{
					function()
						return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 and " Location List"
							or " Quickfix List"
					end,
					separator = SEPARATORS.round1,
				},
			},
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "qf" },
	},
}

local PRETTY_PATH_PROVIDERS = {
	default = "base",
	"toggleterm",
	"trouble",
	"dapui",
	"minifiles",
	"snacks_scratch",
	"snacks_terminal",
	"snacks_picker",
}

local DISABLED_FILETYPES = {
	statusline = { "snacks_dashboard" },
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
		"minifiles",
	},
	tabline = { "snacks_dashboard" },
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "folke/noice.nvim", "cameronr/lualine-pretty-path" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = "catppuccin",
			component_separators = { left = "", right = "" },
			section_separators = SEPARATORS.round1,
			globalstatus = true,
			disabled_filetypes = DISABLED_FILETYPES,
			always_divide_middle = false,
			always_show_tabline = false,
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
					symbols = { added = "", modified = "", removed = "" },
					separator = SEPARATORS.empty,
				},
			},
		lualine_x = {
			{ "overseer", separator = SEPARATORS.empty },
			{
				"diagnostics",
				symbols = { error = "", warn = "", info = "", hint = "󰌶" },
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
					color = function()
						return { fg = get_palette().peach }
					end,
					separator = SEPARATORS.empty,
				},
				{
					function()
						local ok, noice = pcall(require, "noice")
						return ok and noice.api.status.mode.get() or ""
					end,
					cond = function()
						local ok, noice = pcall(require, "noice")
						return ok and noice.api.status.mode.has()
					end,
					color = function()
						return { fg = get_palette().red }
					end,
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
					color = function()
						return { fg = get_palette().peach }
					end,
					separator = SEPARATORS.empty,
				},
			},
			lualine_y = {
				{
					"fileformat",
					section_separators = SEPARATORS.round2,
					cond = function()
						return vim.bo.fileformat ~= "unix"
					end,
					separator = SEPARATORS.empty,
				},
				{ "progress", section_separators = SEPARATORS.round2 },
			},
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
		tabline = {
			lualine_a = {
				{
					"tabs",
					separator = SEPARATORS.round1,
					section_separators = SEPARATORS.round2,
					mode = 2,
					max_length = vim.o.columns,
					cond = function()
						return vim.fn.tabpagenr("$") > 1
					end,
					tabs_color = {
						active = "lualine_a_normal",
						inactive = "lualine_b_normal",
					},
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			extensions.lazy,
			extensions.mason,
			extensions.quickfix,
		},
	},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				cached_palette = nil
			end,
		})
		require("lualine").setup(opts)
	end,
}
