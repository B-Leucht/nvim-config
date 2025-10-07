-- Colorscheme
local constants = require("core.constants")

return {
	constants.APPEARANCE.THEME .. "/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavor = constants.APPEARANCE.FLAVOR,
			term_colors = true,
			default_integrations = true,
			transparent_background = not vim.g.neovide, -- Disable transparency in Neovide
			integrations = {
				cmp = true,
				fzf = true,
				treesitter = true,
				mason = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			-- Disable cursor animations to prevent flickering
			custom_highlights = function(colors)
				return {
					-- Optimize cursor line highlight
					CursorLine = { bg = "NONE" },
					-- Fix visual selection visibility
					Visual = { bg = colors.surface1, fg = "NONE" },
					-- Ensure visual selection is visible in all terminal modes
					VisualNOS = { bg = colors.surface1, fg = "NONE" },
					-- Highlight current line number
					CursorLineNr = { fg = colors.peach, bold = true },
				}
			end,
		})

		vim.cmd.colorscheme(constants.APPEARANCE.THEME)

		-- Force visible visual selection for all terminal modes
		vim.api.nvim_set_hl(0, "Visual", { bg = "#3e4451", fg = "NONE" })
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#3e4451", fg = "NONE" })
	end,
}
