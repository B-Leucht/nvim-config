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
					vim.keymap.set("n", "<leader>rr", function()
						vim.cmd.RustLsp("runnables")
					end, opts("Runnables"))
					vim.keymap.set("n", "<leader>rd", function()
						vim.cmd.RustLsp("debuggables")
					end, opts("Debuggables"))
					vim.keymap.set("n", "<leader>rt", function()
						vim.cmd.RustLsp("testables")
					end, opts("Testables"))
					vim.keymap.set("n", "<leader>re", function()
						vim.cmd.RustLsp("expandMacro")
					end, opts("Expand Macro"))
					vim.keymap.set("n", "<leader>rc", function()
						vim.cmd.RustLsp("openCargo")
					end, opts("Open Cargo.toml"))
					vim.keymap.set("n", "<leader>rp", function()
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
