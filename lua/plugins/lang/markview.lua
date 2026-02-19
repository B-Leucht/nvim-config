return {
	"OXY2DEV/markview.nvim",
	ft = "markdown",
	dependencies = { "saghen/blink.cmp" },
	config = function(_, opts)
		local presets = require("markview.presets")
		opts.markdown.headings = presets.headings.simple

		local function clear_code_bg()
			local groups = {
				"MarkviewCode",
				"MarkviewCodeInfo",
				"MarkviewCodeFg",
				"MarkviewInlineCode",
				"MarkviewCodeBlock",
			}
			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end
			local ok, palettes = pcall(require, "catppuccin.palettes")
			local fg = ok and palettes.get_palette().overlay1 or "#7a7a7a"
			vim.api.nvim_set_hl(0, "MarkviewCodeInfo", { bg = "NONE", fg = fg })
		end
		require("markview").setup(opts)
		vim.schedule(clear_code_bg)
		vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { callback = clear_code_bg })
	end,
	opts = {
		preview = {
			icon_provider = "mini",
			modes = { "n", "no", "c", "i", "v", "V" },
			hybrid_modes = { "n", "i", "v", "V" },
			linewise_hybrid_mode = true,
		},
		markdown = {
			wrap = false,
			tables = { wrap = false },
			code_blocks = {
				enable = true,
				style = "simple",
				hl = "NONE",
				sign = false,
				pad_amount = 0,
				label = false,
			},
		},
		latex = { enable = false },
	},
}
