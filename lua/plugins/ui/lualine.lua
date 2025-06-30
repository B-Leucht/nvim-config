-- Status line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "folke/trouble.nvim", "cameronr/lualine-pretty-path" },
	event = "VeryLazy",
	opts = {
		options = {
			theme = require("core.constants").APPEARANCE.THEME,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
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
					icon = "",
				},
			},
			lualine_b = {
				{
					"pretty_path",
					fmt = (function(trunc_width, trunc_len, hide_width, no_ellipsis)
						return function(str)
							local win_width = vim.o.columns
							if hide_width and win_width < hide_width then
								return ""
							end
							if trunc_len and win_width < trunc_width and #str > trunc_len then
								return no_ellipsis and str:sub(1, trunc_len) or str:sub(1, trunc_len) .. "…"
							end
							return str
						end
					end)(80, 30, 60, true),
				},
			},
			lualine_c = {
				{
					"branch",
					fmt = (function(trunc_width, trunc_len, hide_width, no_ellipsis)
						return function(str)
							local win_width = vim.o.columns
							if hide_width and win_width < hide_width then
								return ""
							end
							if trunc_len and win_width < trunc_width and #str > trunc_len then
								return no_ellipsis and str:sub(1, trunc_len) or str:sub(1, trunc_len) .. "…"
							end
							return str
						end
					end)(70, 15, 65, true),
				},
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					update_in_insert = true,
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

				{
					(function()
						local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV
						if venv then
							return " " .. vim.fn.fnamemodify(venv, ":t")
						end
						return ""
					end)(),
					icon = "",
					color = { fg = "#a6e3a1", gui = "italic" },
				},
				{
					function()
						local ok, lazy_status = pcall(require, "lazy.status")
						if not ok then
							return ""
						end
						return lazy_status.updates()
					end,
					cond = function()
						local ok, lazy_status = pcall(require, "lazy.status")
						if not ok then
							return false
						end
						return lazy_status.has_updates()
					end,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_y = {
				{
					function()
						if not vim.g.custom_lualine_show_lsp_names then
							return ""
						end
						local ok, clients = pcall(vim.lsp.get_clients, { bufnr = 0 })
						if not ok or #clients == 0 then
							return ""
						end
						local names = {}
						for _, client in ipairs(clients) do
							if client.name and client.name ~= "null-ls" and client.name ~= "copilot" then
								table.insert(names, client.name)
							end
						end
						if #names == 0 then
							return ""
						end
						return "󰒋 " .. table.concat(names, " ")
					end,
					cond = function()
						if not vim.g.custom_lualine_show_lsp_names then
							return false
						end
						local ok, clients = pcall(vim.lsp.get_clients, { bufnr = 0 })
						if not ok then
							return false
						end
						for _, client in ipairs(clients) do
							if client.name and client.name ~= "null-ls" and client.name ~= "copilot" then
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
			lualine_z = {
				{ "location", icon = "" },
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
					component_separators = { left = "╲", right = "╱" },
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
						snacks_picker_input = "",
						snacks_picker_list = "󰙅",
						snacks_picker_preview = "",
						snacks_dashboard = "󰕮",
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

						-- Debounced caching to prevent flicker
						local bufnr = vim.api.nvim_get_current_buf()
						local cache_key = "_lualine_trouble_symbols_" .. bufnr

						-- Use debounced function for symbol updates
						local update_symbols = function()
							local cache = {}
							local function debounce(fn, key, timeout)
								timeout = timeout or 1000
								return function(...)
									local now = vim.loop.now()
									if not cache[key] or (now - cache[key].time) > timeout then
										cache[key] = { value = fn(...), time = now }
									end
									return cache[key].value
								end
							end
							return debounce(function()
								return trouble.statusline({
									mode = "lsp_document_symbols",
									groups = {},
									title = false,
									filter = { range = true },
									format = "{kind_icon}{symbol.name:Normal}",
									hl_group = "lualine_c_normal",
								})
							end, cache_key, 500)
						end

						local symbols = update_symbols()
						return symbols and symbols.has() and symbols.get() or " "
					end,
				},
			},
		},
		inactive_winbar = {},
		extensions = {
			"oil",
			"lazy",
			"mason",
			"quickfix",
			"trouble",
			"overseer",
		},
	},
}

