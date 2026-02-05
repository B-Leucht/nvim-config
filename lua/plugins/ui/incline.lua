-- Incline: floating filename labels for splits
return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	dependencies = { "echasnovski/mini.nvim" },
	opts = {
		hide = {
			cursorline = true,
			focused_win = false,
			only_win = true,
		},
		window = {
			padding = 0,
			margin = { horizontal = 0, vertical = 0 },
		},
		highlight = {
			groups = {
				InclineNormal = { guibg = "none" },
				InclineNormalNC = { guibg = "none" },
			},
		},
		render = function(props)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end

			local ft_icon, ft_hl = MiniIcons.get("file", filename)
			local ft_color = vim.api.nvim_get_hl(0, { name = ft_hl, link = false }).fg
			local modified = vim.bo[props.buf].modified
			local bg = props.focused and "#45475a" or "#313244"

			return {
				{ "\u{e0b6}", guifg = bg },
				{ "", guibg = bg },
				{ ft_icon .. " ", guifg = ft_color and string.format("#%06x", ft_color) or nil, guibg = bg },
				{ filename, gui = modified and "bold,italic" or "bold", guibg = bg },
				{ modified and " ●" or "", guifg = "#f9e2af", guibg = bg },
				{ "", guibg = bg },
				{ "\u{e0b4}", guifg = bg },
			}
		end,
	},
}
