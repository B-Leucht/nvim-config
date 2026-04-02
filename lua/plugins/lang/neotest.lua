local gh = require("utils.gh")

return {
	specs = {
		gh("nvim-neotest/neotest"),
		gh("nvim-neotest/nvim-nio"),
		gh("nvim-neotest/neotest-python"),
		gh("nvim-neotest/neotest-jest"),
		gh("mrcjkb/neotest-haskell"),
		gh("fredrikaverpil/neotest-golang"),
	},
	setup = function()
		require("neotest").setup({
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
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
				require("neotest-golang"),
			},
			status = { virtual_text = true },
			output = { open_on_run = false },
		})

		vim.keymap.set("n", "<leader>Tn", function() require("neotest").run.run() end, { desc = "Run Nearest Test" })
		vim.keymap.set("n", "<leader>TF", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run File Tests" })
		vim.keymap.set("n", "<leader>Ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Test Summary" })
		vim.keymap.set("n", "<leader>To", function() require("neotest").output.open({ enter = true }) end, { desc = "Show Test Output" })
		vim.keymap.set("n", "<leader>Tp", function() require("neotest").output_panel.toggle() end, { desc = "Toggle Output Panel" })
		vim.keymap.set("n", "<leader>Td", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Debug Nearest Test" })
		vim.keymap.set("n", "<leader>TS", function() require("neotest").run.stop() end, { desc = "Stop Test" })
		vim.keymap.set("n", "[T", function() require("neotest").jump.prev({ status = "failed" }) end, { desc = "Previous Failed Test" })
		vim.keymap.set("n", "]T", function() require("neotest").jump.next({ status = "failed" }) end, { desc = "Next Failed Test" })
	end,
}
