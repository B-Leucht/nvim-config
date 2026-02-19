vim.g.catppuccin_transparent = true

local function catppuccin_setup()
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
				SnacksImageMath = { fg = colors.text },
				SnacksIndent = { fg = colors.overlay1 },
				SnacksIndentScope = { fg = colors.text },
			}
		end,
	})
	vim.cmd.colorscheme("catppuccin")
end

return {
	"catppuccin/nvim",
	priority = 1000,
	config = function()
		catppuccin_setup()

		vim.keymap.set("n", "<leader>ut", function()
			vim.g.catppuccin_transparent = not vim.g.catppuccin_transparent
			catppuccin_setup()
			local status = vim.g.catppuccin_transparent and "enabled" or "disabled"
			vim.notify("Transparency " .. status, vim.log.levels.INFO)
		end, { desc = "Toggle transparency" })
	end,
}
