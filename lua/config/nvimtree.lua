require("nvim-tree").setup({
	sort = { sorter = "case_sensitive" },
	view = { width = 20 },
	renderer = {
		group_empty = true,
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "",
					ignored = "◌",
				},
			},
		},
	},
	filters = { dotfiles = true },
})
