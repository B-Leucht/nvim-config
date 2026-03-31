local gh = function(x)
	return "https://github.com/" .. x
end

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
	mason = {
		sections = {
			lualine_a = {
				{
					function()
						return " Mason"
					end,
					separator = SEPARATORS.round1,
				},
			},
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
	dap = {
		sections = {
			lualine_a = {
				{
					function()
						return " DAP"
					end,
					separator = SEPARATORS.round1,
				},
			},
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "dap-view", "dap-view-term", "dap-repl" },
	},
	diffview = {
		sections = {
			lualine_a = {
				{
					function()
						return " Diffview"
					end,
					separator = SEPARATORS.round1,
				},
			},
			lualine_b = {
				{ "pretty_path", providers = PRETTY_PATH_PROVIDERS, separator = SEPARATORS.round1 },
			},
			lualine_z = { { "location", separator = SEPARATORS.round1 } },
		},
		filetypes = { "DiffviewFiles", "DiffviewFileHistory" },
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
		"DiffviewFiles",
		"DiffviewFileHistory",
	},
	tabline = { "snacks_dashboard" },
}

return {
	specs = {
		gh("nvim-lualine/lualine.nvim"),
		gh("cameronr/lualine-pretty-path"),
	},
	setup = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				cached_palette = nil
			end,
		})
		require("lualine").setup({
			options = {
				theme = "catppuccin-nvim",
				component_SEPARATORS = { left = "", right = "" },
				section_separators = SEPARATORS.round1,
				globalstatus = true,
				disabled_filetypes = DISABLED_FILETYPES,
				always_divide_middle = false,
				always_show_tabline = false,
				refresh = { statusline = 100 },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = SEPARATORS.round1,
						fmt = function(str)
							local mode_map = {
								normal = "n",
								insert = "i",
								visual = "v",
								["v-line"] = "vl",
								["v-block"] = "vb",
								command = "c",
								replace = "r",
								select = "s",
								terminal = "t",
							}
							return mode_map[str] or str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{ "pretty_path", providers = PRETTY_PATH_PROVIDERS, separator = SEPARATORS.round1 },
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
					{ "-S", separator = SEPARATORS.empty },
					{
						function()
							return require("recorder").displaySlots()
						end,
						cond = function()
							return package.loaded["recorder"] ~= nil
						end,
						separator = SEPARATORS.empty,
					},
					{
						function()
							return require("recorder").recordingStatus()
						end,
						cond = function()
							return package.loaded["recorder"] ~= nil
						end,
						separator = SEPARATORS.empty,
					},
					{ "overseer", separator = SEPARATORS.empty },
					{
						"diagnostics",
						symbols = { error = "", warn = "", info = "", hint = "󰌶" },
						update_in_insert = false,
						separator = SEPARATORS.empty,
					},
					{
						function()
							return require("noice").api.status.search.get_hl()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.search.has()
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
					{ "minuet", separator = SEPARATORS.empty },
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
				extensions.mason,
				extensions.quickfix,
				extensions.dap,
				extensions.diffview,
			},
		})
	end,
}
