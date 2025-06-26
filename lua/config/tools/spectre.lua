require("spectre").setup({
	open_cmd = "noswapfile vnew",
	live_update = false,
	line_sep_start = "┌-----------------------------------------",
	result_padding = "¦  ",
	line_sep = "└-----------------------------------------",
	highlight = {
		ui = "String",
		search = "DiffChange",
		replace = "DiffDelete",
	},
	is_insert_mode = true,
	default = {
		replace = {
			cmd = "oxi",
		},
	},
})