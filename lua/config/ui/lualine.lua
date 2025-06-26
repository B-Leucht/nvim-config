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

local function get_macro_recording()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "Recording @" .. reg
end

return {
	options = {
		theme = constants.APPEARANCE.THEME,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "snacks_dashboard" },
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
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
				function()
					if vim.bo.filetype == "oil" then
						local ok, oil = pcall(require, "oil")
						if ok then
							return " " .. oil.get_current_dir()
						end
					end

					local filename = vim.fn.expand("%:t")
					if filename == "" then
						return "[No Name]"
					end

					local ok, mini_icons = pcall(require, "mini.icons")
					if ok then
						local icon, hl = mini_icons.get("file", filename)
						return icon .. " " .. filename
					end
					return filename
				end,
				color = function()
					if vim.bo.modified then
						return { fg = "#fab387", gui = "bold,italic" }
					elseif vim.bo.readonly then
						return { fg = "#f38ba8", gui = "bold" }
					end
					return { gui = "bold" }
				end,
			},
			{
				get_short_cwd,
				icon = "",
				color = { fg = "#6c7086", gui = "italic" },
				cond = function()
					return vim.fn.expand("%") ~= ""
				end,
			},
			{
				"diagnostics",
				sources = { "nvim_lsp", "nvim_diagnostic" },
				symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
				diagnostics_color = {
					error = { fg = "#f38ba8" },
					warn = { fg = "#fab387" },
					info = { fg = "#89b4fa" },
					hint = { fg = "#a6e3a1" },
				},
				update_in_insert = false,
			},
			{
				get_macro_recording,
				color = { fg = "#f38ba8", gui = "bold" },
			},
		},
		lualine_x = {
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
		},
		lualine_y = {

			{
				"filetype",
				colored = true,
				icon_only = true,
				icon = function()
					local ok, mini_icons = pcall(require, "mini.icons")
					if ok then
						local filename = vim.fn.expand("%:t")
						if filename ~= "" then
							local icon, hl = mini_icons.get("file", filename)
							return icon
						end
					end
					return nil
				end,
			},
		},
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
		lualine_c = {
			{
				function()
					if vim.bo.filetype == "oil" then
						local ok, oil = pcall(require, "oil")
						if ok then
							return " " .. oil.get_current_dir()
						end
					end

					-- Get file icon for inactive windows too
					local ok, mini_icons = pcall(require, "mini.icons")
					if ok then
						local filename = vim.fn.expand("%:t")
						if filename ~= "" then
							local icon, hl = mini_icons.get("file", filename)
							return icon .. " %f"
						end
					end
					return "%f"
				end,
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- Added missing sections
	tabline = {},
	winbar = {},
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
