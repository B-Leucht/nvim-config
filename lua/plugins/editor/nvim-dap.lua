return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"igorlfs/nvim-dap-view",
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
	},
	config = function()
		local dap = require("dap")

		-- Setup nvim-dap-python
		require("dap-python").setup("python3")

		-- Setup C/C++ debugging with codelldb
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Launch with AddressSanitizer",
				type = "codelldb",
				request = "launch",
				program = function()
					local current_file = vim.fn.expand("%:r")
					local asan_binary = current_file .. "_address"
					if vim.fn.executable(asan_binary) == 1 then
						return vim.fn.getcwd() .. "/" .. asan_binary
					else
						return vim.fn.input("Path to ASan executable: ", vim.fn.getcwd() .. "/", "file")
					end
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				env = {
					ASAN_OPTIONS = "halt_on_error=1:abort_on_error=1:detect_leaks=1:check_initialization_order=1:strict_init_order=1",
				},
				args = {},
			},
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = function()
					return tonumber(vim.fn.input("Process ID: "))
				end,
			},
		}

		dap.configurations.cpp = dap.configurations.c
	end,
}
