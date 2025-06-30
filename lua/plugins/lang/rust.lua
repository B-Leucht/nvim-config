-- Rust support
return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	ft = "rust",
	init = function()
		vim.g.rustaceanvim = {
			server = {
				cmd = function()
					local mason_registry = require("mason-registry")
					local ra_binary = mason_registry.is_installed("rust-analyzer")
							and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
						or "rust-analyzer"
					return { ra_binary }
				end,
			},
		}
	end,
},
{
	"saecki/crates.nvim",
	event = "BufRead Cargo.toml",
	ft = "toml",
	opts = {
		completion = {
			cmp = {
				enabled = true,
			},
		},
	},
}