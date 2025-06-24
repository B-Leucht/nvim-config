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
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		-- Updated offsets for Oil.nvim instead of NvimTree
		offsets = {
			{
				filetype = "toggleterm",
				text = "Terminal",
				highlight = "Directory",
				text_align = "center",
				separator = true,
			},
			{
				filetype = "NeogitStatus",
				text = "Neogit",
				highlight = "Directory",
				text_align = "center",
				separator = true,
			},
			{
				filetype = "snacks_terminal",
				text = "Claude",
				highlight = "Directory",
				text_align = "center",
				separator = true,
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
		-- Filter out Oil buffers from BufferLine tabs
		custom_filter = function(buf_number)
			local buf_name = vim.fn.bufname(buf_number)
			-- Hide Oil buffers (they start with "oil://")
			if string.match(buf_name, "^oil://") then
				return false
			end
			-- Hide any buffer that doesn't have a real file name
			if buf_name == "" then
				return false
			end
			return true
		end,
		-- Better buffer management with bufdelete
		close_command = function(bufnr)
			-- Use bufdelete instead of bdelete to preserve window layout
			require("bufdelete").bufdelete(bufnr, true)
		end,
		right_mouse_command = function(bufnr)
			-- Right click to close buffer using bufdelete
			require("bufdelete").bufdelete(bufnr, true)
		end,
		middle_mouse_command = function(bufnr)
			-- Middle click to close buffer using bufdelete
			require("bufdelete").bufdelete(bufnr, true)
		end,
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(), -- optional
})
