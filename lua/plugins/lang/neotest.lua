return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest",
		"mrcjkb/rustaceanvim",
		"mrcjkb/neotest-haskell",
	},
	keys = {
		{ "<leader>Tn", function() require("neotest").run.run() end, desc = "Run Nearest Test" },
		{ "<leader>TF", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File Tests" },
		{ "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Test Summary" },
		{ "<leader>To", function() require("neotest").output.open({ enter = true }) end, desc = "Show Test Output" },
		{ "<leader>Tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
		{ "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest Test" },
		{ "<leader>TS", function() require("neotest").run.stop() end, desc = "Stop Test" },
		{ "[T", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Previous Failed Test" },
		{ "]T", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next Failed Test" },
	},
	opts = function()
		return {
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
				}),
				require("neotest-jest")({
					jestCommand = "npx jest",
				}),
				require("rustaceanvim.neotest"),
				require("neotest-haskell"),
			},
			status = { virtual_text = true },
			output = { open_on_run = false },
		}
	end,
}
