require("fzf-lua").setup({
	winopts = {
		height = 0.85,
		width = 0.80,
		row = 0.35,
		col = 0.50,
		border = "rounded",
		fullscreen = false,
		preview = {
			layout = "vertical",
			vertical = "up:60%",
			wrap = "wrap",
			scrollbar = "float",
			border = "none",
		},
	},
})

vim.ui.select = function(items, opts, on_choice)
	local fzf = require("fzf-lua")
	fzf.fzf_select(items, {
		prompt = opts.prompt or "Select one",
		format_item = opts.format_item or tostring,
	}, on_choice)
end
