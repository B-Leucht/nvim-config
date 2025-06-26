require("lualine").setup({
	options = {
		theme = "catppuccin",
		section_separators = "",
		component_separators = "",
		icons_enabled = true,
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "alpha", "oil" },
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1) -- Show only first letter (N, I, V, etc.)
				end,
			},
		},
		lualine_b = {
			{
				"branch",
				icon = "",
				fmt = function(str)
					if string.len(str) > 20 then
						return string.sub(str, 1, 17) .. "..."
					end
					return str
				end,
			},
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
		},
		lualine_c = {
			{
				"filename",
				path = 1, -- Show relative path
				shorting_target = 40,
				symbols = {
					modified = "●",
					readonly = "",
					unnamed = "[No Name]",
				},
			},
		},

		lualine_x = {
			{
				require("noice").api.status.message.get_hl,
				cond = require("noice").api.status.message.has,
			},
			{
				require("noice").api.status.command.get,
				cond = require("noice").api.status.command.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.mode.get,
				cond = require("noice").api.status.mode.has,
				color = { fg = "#ff9e64" },
			},
			{
				require("noice").api.status.search.get,
				cond = require("noice").api.status.search.has,
				color = { fg = "#ff9e64" },
			},
		},

		-- lualine_x = {
		--
		-- 	{
		-- 		"filetype",
		-- 		icons_enabled = true,
		-- 		colored = false,
		-- 	},
		-- },
		lualine_y = {
			{
				"progress",
				fmt = function(str)
					return str:gsub("%%", "")
				end,
			},
		},
		lualine_z = {
			{
				"location",
				fmt = function(str)
					return str:gsub(" ", "")
				end,
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
