return {
	options = {
		mode = "buffers",
		themable = true,
		numbers = "none",
		close_command = function(bufnum)
			require("snacks.bufdelete").delete(bufnum)
		end,
		right_mouse_command = function(bufnum)
			require("snacks.bufdelete").delete(bufnum)
		end,
		left_mouse_command = "buffer %d",
		middle_mouse_command = function(bufnum)
			require("snacks.bufdelete").delete(bufnum)
		end,

		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 30,
		max_prefix_length = 30,
		tab_size = 21,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
		offsets = {

			{
				filetype = "snacks_terminal",
				text = "Terminal",
				text_align = "left",
				separator = true,
			},
		},
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "thin",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		sort_by = "insert_after_current",
	},
}
