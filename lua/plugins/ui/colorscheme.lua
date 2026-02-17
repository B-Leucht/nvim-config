vim.g.catppuccin_transparent = true

return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavor = "mocha",
			transparent_background = vim.g.catppuccin_transparent,
			term_colors = true,
			default_integrations = true,
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
			custom_highlights = function(colors)
				return {
					CursorLine = { bg = "NONE" },
					Visual = { bg = colors.surface1, fg = "NONE" },
					VisualNOS = { bg = colors.surface1, fg = "NONE" },
					CursorLineNr = { fg = colors.peach, bold = true },
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE", fg = colors.lavender },
					FloatTitle = { bg = "NONE", fg = colors.lavender },
					WhichKeyFloat = { bg = "NONE" },
					WhichKeyBorder = { bg = "NONE", fg = colors.lavender },
					SnacksNormal = { bg = "NONE" },
					SnacksPicker = { bg = "NONE" },
					SnacksPickerBorder = { bg = "NONE", fg = colors.lavender },
					SnacksNotifierHistory = { bg = "NONE" },
					NoicePopup = { bg = "NONE" },
					NoicePopupBorder = { bg = "NONE", fg = colors.lavender },
					NoiceCmdlinePopup = { bg = "NONE" },
					NoiceCmdlinePopupBorder = { bg = "NONE", fg = colors.lavender },
					LspCodeLens = { fg = colors.teal, italic = true },
					BlinkPairsOrange = { fg = colors.peach },
					BlinkPairsPurple = { fg = colors.mauve },
					BlinkPairsBlue = { fg = colors.blue },
					BlinkPairsUnmatched = { fg = colors.red },
					BlinkPairsMatchParen = { fg = colors.yellow, bold = true },
				}
			end,
		})

		vim.cmd.colorscheme("catppuccin")

		vim.api.nvim_set_hl(0, "Visual", { bg = "#3e4451", fg = "NONE" })
		vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#3e4451", fg = "NONE" })

		vim.keymap.set("n", "<leader>ut", function()
			vim.g.catppuccin_transparent = not vim.g.catppuccin_transparent
			require("catppuccin").setup({
				flavor = "mocha",
				transparent_background = vim.g.catppuccin_transparent,
			})
			vim.cmd.colorscheme("catppuccin")
			vim.api.nvim_set_hl(0, "Visual", { bg = "#3e4451", fg = "NONE" })
			vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#3e4451", fg = "NONE" })

			local status = vim.g.catppuccin_transparent and "enabled" or "disabled"
			vim.notify("Transparency " .. status, vim.log.levels.INFO)
		end, { desc = "Toggle transparency" })
	end,
}
