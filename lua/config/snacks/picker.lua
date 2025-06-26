return {
	enabled = true,
	sources = {
		buffers = {
			name = "Buffers",
		},
		files = {
			name = "Files",
		},
		grep = {
			name = "Grep",
		},
	},
	win = {
		input = {
			keys = {
				["<C-j>"] = { "move", "down" },
				["<C-k>"] = { "move", "up" },
			},
		},
	},
}