-- Noice: cmdline popup only (notifications/messages handled by snacks)
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
			enabled = false, -- Use default nvim messages
		},
		popupmenu = {
			enabled = true,
			backend = "nui",
		},
		lsp = {
			progress = { enabled = false },
			signature = { enabled = false }, -- blink.cmp handles this
			hover = { enabled = false }, -- use native LSP hover
			message = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		notify = {
			enabled = false, -- snacks.notifier handles this
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = false,
			lsp_doc_border = true,
		},
	},
}
