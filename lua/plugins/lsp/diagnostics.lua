return {
	"dgagn/diagflow.nvim",
	event = "LspAttach",
	opts = {
		scope = "cursor",
		padding_top = 2,
		max_width = 60,
		show_borders = true,
		border_chars = {
			top_left = "╭",
			top_right = "╮",
			bottom_left = "╰",
			bottom_right = "╯",
			horizontal = "─",
			vertical = "│",
		},
		show_sign = true,
		severity_colors = {
			error = "DiagnosticError",
			warning = "DiagnosticWarn",
			info = "DiagnosticInfo",
			hint = "DiagnosticHint",
		},
	},
}
