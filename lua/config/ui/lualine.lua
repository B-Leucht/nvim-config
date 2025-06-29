local constants = require("core.constants")

local function get_short_cwd()
	local cwd = vim.fn.getcwd()
	local home = vim.fn.expand("~")
	if cwd:find(home, 1, true) == 1 then
		cwd = "~" .. cwd:sub(#home + 1)
	end
	return vim.fn.pathshorten(cwd, 3)
end

local function get_python_venv()
	local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV
	if venv then
		return " " .. vim.fn.fnamemodify(venv, ":t")
	end
	return ""
end

return {
	options = {
		theme = constants.APPEARANCE.THEME,
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "snacks_dashboard" },
			winbar = {
				"oil",
				"trouble",
				"lazy",
				"mason",
				"help",
				"qf",
				"quickfix",
				"TelescopePrompt",
				"snacks_picker",
				"snacks_terminal",
				"snacks_dashboard",
			},
			tabline = { "snacks_dashboard" },
		},
		ignore_focus = {},
		always_divide_middle = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 2000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 3)
				end,
			},
		},
		lualine_b = {
			"branch",
			"diff",
		},
		lualine_c = {
			{
				"filename",
				file_status = true,
				symbols = {
					modified = " ●",
					readonly = " ",
					unnamed = "[No Name]",
					newfile = " ",
				},
			},

			{
				get_short_cwd,
				icon = "",
				color = { fg = "#6c7086", gui = "italic" },
				cond = function()
					return vim.fn.expand("%") ~= ""
				end,
			},
		},
		lualine_x = {
			{
				"searchcount",
				maxcount = 999,
				timeout = 500,
			},
			{
				"selectioncount",
				fmt = function(str)
					return str ~= "" and "󰒅 " .. str or ""
				end,
			},

			{
				get_python_venv,
				icon = "",
				color = { fg = "#a6e3a1", gui = "italic" },
			},
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					local names = {}
					for _, client in ipairs(clients) do
						if client.name ~= "null-ls" and client.name ~= "copilot" then
							table.insert(names, client.name)
						end
					end
					if #names == 0 then
						return ""
					end
					return "󰒋 " .. table.concat(names, " ")
				end,
				color = { fg = "#cba6f7", gui = "italic" },
				cond = function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					for _, client in ipairs(clients) do
						if client.name ~= "null-ls" and client.name ~= "copilot" then
							return true
						end
					end
					return false
				end,
			},
			{
				function()
					local ok, conform = pcall(require, "conform")
					if not ok then
						return ""
					end
					local formatters_ok, formatters = pcall(conform.list_formatters, 0)
					if not formatters_ok or #formatters == 0 then
						return ""
					end
					local names = {}
					for _, formatter in ipairs(formatters) do
						if formatter.name then
							table.insert(names, formatter.name)
						end
					end
					if #names == 0 then
						return ""
					end
					return "󰉼 " .. table.concat(names, " ")
				end,
				color = { fg = "#94e2d5", gui = "italic" },
				cond = function()
					local ok, conform = pcall(require, "conform")
					if not ok then
						return false
					end
					local formatters_ok, formatters = pcall(conform.list_formatters, 0)
					return formatters_ok and #formatters > 0
				end,
			},
			{
				function()
					local ok = pcall(require, "copilot")
					if not ok then
						return ""
					end
					return "󰚩"
				end,
				color = function()
					if vim.g.copilot_enabled == false then
						return { fg = "#6c7086" }
					end
					return { fg = "#a6e3a1" }
				end,
				cond = function()
					return pcall(require, "copilot")
				end,
			},
		},
		lualine_y = { "diagnostics" },
		lualine_z = {
			{
				"location",
				fmt = function(str)
					return str:gsub(" ", ":")
				end,
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				mode = 2,
				show_filename_only = true,
				show_modified_status = true,
				hide_filename_extension = false,
				symbols = {
					modified = " ●",
					alternate_file = "",
					directory = " ",
				},
				filetype_names = {
					oil = "",
					trouble = "Trouble",
					lazy = "Lazy",
					mason = "Mason",
					snacks_picker_input = "Picker",
					snacks_picker_list = "Explorer",
					snacks_picker_preview = "Picker",
					snacks_dashboard = "Dashboard",
				},
				buffers_color = {
					active = "lualine_a_normal",
					inactive = "lualine_b_normal",
				},
			},
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {
			{
				function()
					local ok, noice = pcall(require, "noice")
					if not ok then
						return ""
					end
					return noice.api.statusline.mode.get()
				end,
				cond = function()
					local ok, noice = pcall(require, "noice")
					if not ok then
						return false
					end
					return noice.api.statusline.mode.has()
				end,
				color = { fg = "#ff9e64" },
			},
		},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
	winbar = {
		lualine_c = {
			{
				function()
					local ok, trouble = pcall(require, "trouble")
					if not ok then
						return " "
					end

					-- Cache the symbols object to avoid multiple calls
					if not vim.b._lualine_trouble_symbols then
						vim.b._lualine_trouble_symbols = trouble.statusline({
							mode = "lsp_document_symbols",
							groups = {},
							title = false,
							filter = { range = true },
							format = "{kind_icon}{symbol.name:Normal}",
							hl_group = "lualine_c_normal",
						})
					end

					local symbols = vim.b._lualine_trouble_symbols
					return symbols.has() and symbols.get() or " "
				end,
			},
		},
	},
	inactive_winbar = {},
	-- Extensions
	extensions = {
		"oil",
		"lazy",
		"mason",
		"quickfix",
		"trouble",
		"overseer",
	},
}
