return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"folke/noice.nvim",
		"cameronr/lualine-pretty-path",
		"AndreM222/copilot-lualine",
	},
	event = "VeryLazy",
	init = function()
		vim.g.lualine_disabled = true
	end,
	opts = {
		options = {
			theme = require("core.constants").APPEARANCE.THEME,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
			disabled_filetypes = {
				statusline = { "snacks_dashboard" },
				winbar = {
					-- "oil",
					-- "trouble",
					"lazy",
					"mason",
					"help",
					"qf",
					"quickfix",
					-- "snacks_picker",
					-- "snacks_terminal",
					"snacks_dashboard",
					"nvim-dap-view",
					"dap-view",
					"dap-view-term",
					"dap-repl",
					"terminal",
				},
				tabline = { "snacks_dashboard" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			refresh = {
				statusline = 2000,
				tabline = 2000,
				winbar = 3000,
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
					"filetype",
					icon_only = true,
					padding = { left = 1, right = 0 },
				},
				{
					"filename",
					file_status = false,
					path = 0,
					shorting_target = 20,
				},
			},
			lualine_c = {
				"branch",
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					update_in_insert = false,
				},
				-- {
				-- 	"searchcount",
				-- 	maxcount = 999,
				-- 	timeout = 500,
				-- 	icon = "",
				-- },
				{
					function()
						local ok, noice = pcall(require, "noice")
						if not ok then
							return ""
						end
						return noice.api.status.search.get()
					end,
					cond = function()
						local ok, noice = pcall(require, "noice")
						if not ok then
							return false
						end
						return noice.api.status.search.has()
					end,
					color = { fg = "#ff9e64" },
				},
				{
					"selectioncount",
					fmt = function(str)
						return str ~= "" and "󰒅 " .. str or ""
					end,
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
						if vim.g.custom_lualine_show_names then
							return "󰒋 " .. table.concat(names, " ")
						else
							return "󰒋"
						end
					end,
					cond = function()
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
						if vim.g.custom_lualine_show_names then
							return "󰉼 " .. table.concat(names, " ")
						else
							return "󰉼"
						end
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
						local ok, lint = pcall(require, "lint")
						if not ok then
							return ""
						end
						local linters_by_ft = lint.linters_by_ft[vim.bo.filetype] or {}
						if #linters_by_ft == 0 then
							return ""
						end
						if vim.g.custom_lualine_show_names then
							return "󰁨 " .. table.concat(linters_by_ft, " ")
						else
							return "󰁨"
						end
					end,
					color = { fg = "#f38ba8", gui = "italic" },
					cond = function()
						local ok, lint = pcall(require, "lint")
						if not ok then
							return false
						end
						local linters_by_ft = lint.linters_by_ft[vim.bo.filetype] or {}
						return #linters_by_ft > 0
					end,
				},
				"copilot",
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
					use_mode_colors = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "┃", right = "┃" },
					show_filename_only = true,
					show_modified_status = true,
					hide_filename_extension = false,
					symbols = { modified = "_󰷥", alternate_file = "", directory = " " },
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
						local cwd = vim.fn.getcwd()
						local home_cwd = vim.fn.fnamemodify(cwd, ":~")
						local parts = vim.split(home_cwd, "/", { plain = true })
						if #parts > 3 then
							return "…/" .. table.concat({ parts[#parts - 1], parts[#parts] }, "/")
						end
						return home_cwd
					end,
					color = { fg = "#6c7086" },
				},
			},
			lualine_y = {},
			lualine_z = { "tabs" },
		},
		winbar = {
			lualine_c = {
				{
					"pretty_path",
					providers = {
						default = "base",
						"snacks_terminal",
						"toggleterm",
						"oil",
						"trouble",
						"dapui",
					},
				},
			},
		},
		inactive_winbar = {
			lualine_c = {
				{
					"pretty_path",
					providers = {
						default = "base",
						"snacks_terminal",
						"toggleterm",
						"oil",
						"trouble",
						"dapui",
					},
				},
			},
		},
		extensions = {
			-- "oil",
			"lazy",
			"mason",
			"quickfix",
			-- "trouble",
			"overseer",
		},
	},
	config = function(_, opts)
		local lualine = require("lualine")
		if not vim.g.lualine_disabled then
			lualine.setup(opts)
		end
	end,
	keys = {
		{
			"<leader>ul",
			function()
				local lualine = require("lualine")
				if vim.g.lualine_disabled then
					-- Enable lualine
					vim.g.lualine_disabled = false
					lualine.setup(
						require("lazy.core.plugin").values(
							require("lazy.core.config").spec.plugins["lualine.nvim"],
							"opts",
							false
						)
					)
					vim.opt.laststatus = 3 -- globalstatus
					vim.cmd("redrawstatus!")
				else
					-- Disable lualine completely
					vim.g.lualine_disabled = true
					pcall(lualine.hide, { place = { "statusline", "tabline", "winbar" }, unhide = false })
					vim.opt.laststatus = 2 -- standard statusline
					vim.opt.statusline = ""
					vim.cmd("redrawstatus!")
				end
			end,
			desc = "Toggle Lualine",
		},
	},
}
