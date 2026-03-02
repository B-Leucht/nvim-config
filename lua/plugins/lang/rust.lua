return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			server = {
				on_attach = function(_, bufnr)
					local opts = function(desc)
						return { buffer = bufnr, desc = desc }
					end
					vim.keymap.set("n", "<localleader>rr", function()
						vim.cmd.RustLsp("runnables")
					end, opts("Runnables"))
					vim.keymap.set("n", "<localleader>rd", function()
						vim.cmd.RustLsp("debuggables")
					end, opts("Debuggables"))
					vim.keymap.set("n", "<localleader>rt", function()
						vim.cmd.RustLsp("testables")
					end, opts("Testables"))
					vim.keymap.set("n", "<localleader>re", function()
						vim.cmd.RustLsp("expandMacro")
					end, opts("Expand Macro"))
					vim.keymap.set("n", "<localleader>rc", function()
						vim.cmd.RustLsp("openCargo")
					end, opts("Open Cargo.toml"))
					vim.keymap.set("n", "<localleader>rp", function()
						vim.cmd.RustLsp("parentModule")
					end, opts("Parent Module"))
				end,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = true,
						check = {
							command = "clippy",
						},
					},
				},
			},
		}
	end,
}
