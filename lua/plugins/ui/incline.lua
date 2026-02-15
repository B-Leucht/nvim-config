-- Incline: floating filename labels for splits
return {
	"b0o/incline.nvim",
	event = "VeryLazy",
	dependencies = { "echasnovski/mini.nvim", "SmiteshP/nvim-navic" },
	opts = {
		hide = {
			cursorline = true,
			focused_win = false,
			only_win = false,
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
			local navic = require("nvim-navic")
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end

			local ft_icon, ft_hl = MiniIcons.get("file", filename)
			local ft_color = vim.api.nvim_get_hl(0, { name = ft_hl, link = false }).fg
			local modified = vim.bo[props.buf].modified
			local bg = props.focused and "#45475a" or "#313244"

			local res = {
				{ "\u{e0b6}", guifg = bg },
				{ "", guibg = bg },
				{ ft_icon .. " ", guifg = ft_color and string.format("#%06x", ft_color) or nil, guibg = bg },
				{ filename, gui = "bold", guifg = modified and "#fab387" or nil, guibg = bg },
				-- { modified and " ●" or "", guifg = "#f9e2af", guibg = bg },
			}

			-- if props.focused and navic.is_available(props.buf) then
			-- 	for _, item in ipairs(navic.get_data(props.buf) or {}) do
			-- 		table.insert(res, { " › ", guifg = "#6c7086", guibg = bg })
			-- 		table.insert(res, { item.icon .. item.name, guifg = "#cdd6f4", guibg = bg })
			-- 	end
			-- end

			table.insert(res, { "", guibg = bg })
			table.insert(res, { "\u{e0b4}", guifg = bg })

			return res
		end,
	},
}
