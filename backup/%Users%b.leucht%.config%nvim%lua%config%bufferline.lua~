vim.opt.termguicolors = true

require("bufferline").setup({
	options = {
		mode = "buffers", -- "tabs" | "buffers"
		numbers = "ordinal", -- or "buffer_id" or false
		indicator = {
			style = "icon", -- or "underline" | "none"
			icon = "▎",
		},
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "center",
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "thin", -- "slant" | "thick" | "thin" | { 'left', 'right' }
		enforce_regular_tabs = false,
		always_show_bufferline = false,
		sort_by = "insert_after_current",
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(), -- optional
})
