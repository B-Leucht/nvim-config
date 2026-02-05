-- Noice: cmdline popup + messages routed to split for long output
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},
		messages = {
			enabled = true,
			view = "mini", -- Short messages show as mini popup
			view_error = "notify",
			view_warn = "notify",
			view_history = "messages",
			view_search = "virtualtext",
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		lsp = {
			progress = {
				enabled = true,
				view = "mini", -- Shows as small popup in corner
			},
			signature = { enabled = false }, -- blink.cmp handles this
			hover = {
				enabled = true,
				view = nil, -- use default
				opts = {
					border = {
						style = "rounded",
					},
					position = { row = 2, col = 2 },
				},
			},
			message = { enabled = true, view = "mini" },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		notify = {
			enabled = false, -- snacks.notifier handles this
		},
		routes = {
			-- Use classic confirm dialog (fixes mini.files sync confirmation)
			{
				filter = {
					event = "msg_show",
					kind = "confirm",
				},
				view = "confirm",
			},
			-- Skip jdtls (Java) progress spam
			{
				filter = {
					event = "lsp",
					kind = "progress",
					cond = function(message)
						local client = vim.tbl_get(message.opts, "progress", "client")
						return client == "jdtls"
					end,
				},
				opts = { skip = true },
			},
			-- Route long messages (like :TSInstall output) to a split buffer
			{
				filter = {
					event = "msg_show",
					min_height = 5,
				},
				view = "split",
			},
			-- Skip "written" messages
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
			-- Skip search count messages
			{
				filter = {
					event = "msg_show",
					kind = "search_count",
				},
				opts = { skip = true },
			},
		},
		views = {
			split = {
				enter = true,
				size = "40%",
				close = {
					keys = { "q", "<Esc>" },
				},
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
	},
	keys = {
		{ "<leader>nm", "<cmd>Noice<cr>", desc = "Message History" },
		{ "<leader>nd", "<cmd>Noice dismiss<cr>", desc = "Dismiss All" },
		{ "<leader>nl", "<cmd>Noice last<cr>", desc = "Last Message" },
		{ "<leader>ne", "<cmd>Noice errors<cr>", desc = "Error Messages" },
	},
}
