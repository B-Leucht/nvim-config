-- Enhanced UI messages
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"folke/snacks.nvim",
	},
	opts = {
		cmdline = {
			view = "cmdline_popup", -- Use floating cmdline
			format = {
				cmdline = { icon = "", title = "" },
				search_down = { icon = " " },
				search_up = { icon = " " },
				filter = { icon = "$", title = "" },
			},
		},
		messages = {
			enabled = true,
			view = "notify", -- Use snacks.notifier backend for messages
		},
		popupmenu = {
			enabled = true, -- Enable wildmenu/popupmenu UI
		},
		lsp = {
			progress = {
				enabled = false,
				format = "lsp_progress",
				throttle = 1000 / 30,
				view = "mini", -- Adjusted view size to smaller
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true,
					luasnip = true,
				},
			},
			hover = {
				enabled = true,
			},
		},
		notify = {
			enabled = true,
		},
		presets = {
			bottom_search = true, -- Replace `/` and `?`
			command_palette = true, -- Command mode overlay
			long_message_to_split = true, -- Send long messages to split
			inc_rename = false,
			lsp_doc_border = true,
		},
		-- Noice will automatically use snacks.notifier when available
	},
}