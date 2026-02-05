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
			vim.api.nvim_set_hl(0, "MarkviewCodeInfo", { bg = "NONE", fg = "#7a7a7a" })
		end
		require("markview").setup(opts)
		clear_code_bg()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_code_bg })
	end,
	opts = {
		preview = {
			icon_provider = "mini",
			modes = { "n", "no", "c", "i", "v", "V" },
			hybrid_modes = { "n", "i", "v", "V" },
			linewise_hybrid_mode = true,
		},
		markdown = {
			code_blocks = {
				enable = true,
				style = "simple",
				hl = "NONE",
				sign = false,
				pad_amount = 0,
				label = false,
			},
		},
	},
}
