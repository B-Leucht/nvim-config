return {
	"mrcjkb/rustaceanvim",
	version = "^7",
	lazy = false,
	init = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},
		}
	end,
}
