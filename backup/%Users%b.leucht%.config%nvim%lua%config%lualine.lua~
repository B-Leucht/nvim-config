require("lualine").setup({
	options = {
		theme = "catppuccin",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		icons_enabled = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" }, -- Git + LSP
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
