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
			view = "mini",
			view_error = "notify",
			view_warn = "mini",
			view_history = "messages",
			view_search = false,
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		lsp = {
			progress = {
				enabled = true,
				view = "mini",
			},
			signature = { enabled = false },
			hover = {
				enabled = true,
				view = nil,
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
			enabled = false,
		},
		routes = {
			{
				filter = { event = "msg_show", kind = "confirm" },
				view = "confirm",
			},
			{
				filter = { event = "msg_show", min_height = 5 },
				view = "split",
			},
			{
				filter = { event = "lsp", kind = "progress" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", kind = "", find = "written" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "%d+ lines? " },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "%d+ more lines?" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "%d+ fewer lines?" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "%d+ substitution" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "Already at" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "search hit" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", find = "Pattern not found" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", max_length = 1 },
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
