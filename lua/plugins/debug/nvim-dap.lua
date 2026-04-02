local gh = require("utils.gh")

return {
	specs = {
		gh("mfussenegger/nvim-dap"),
		gh("mfussenegger/nvim-dap-python"),
		gh("leoluz/nvim-dap-go"),
		gh("theHamsta/nvim-dap-virtual-text"),
	},
	setup = function()
		local dap = require("dap")

		vim.keymap.set("n", "<leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", function()
			dap.continue()
		end, { desc = "Continue" })
		vim.keymap.set("n", "<leader>di", function()
			dap.step_into()
		end, { desc = "Step Into" })
		vim.keymap.set("n", "<leader>do", function()
			dap.step_out()
		end, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>dO", function()
			dap.step_over()
		end, { desc = "Step Over" })
		vim.keymap.set("n", "<leader>dt", function()
			dap.terminate()
		end, { desc = "Terminate" })
		vim.keymap.set("n", "<leader>dk", function()
			require("dap.ui.widgets").hover()
		end, { desc = "DAP Hover (inspect)" })
		vim.keymap.set("n", "<leader>dr", function()
			dap.repl.toggle()
		end, { desc = "Toggle REPL" })

		-- Setup nvim-dap-python (neovim venv has debugpy, but run code with project venv)
		require("dap-python").setup(vim.g.python3_host_prog or "python3")
		require("dap-python").resolve_python = function()
			if vim.env.VIRTUAL_ENV then
				return vim.env.VIRTUAL_ENV .. "/bin/python"
			end
			local cwd_venv = vim.fn.getcwd() .. "/.venv/bin/python"
			if vim.fn.executable(cwd_venv) == 1 then
				return cwd_venv
			end
			return "python3"
		end

		-- Workaround: nvim-dap doesn't respect winfixbuf, temporarily unset before jumping
		dap.defaults.fallback.switchbuf = "useopen,uselast"
		local function clear_winfixbuf()
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				if vim.wo[win].winfixbuf and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
					vim.wo[win].winfixbuf = false
				end
			end
		end
		dap.listeners.before.event_stopped.winfixbuf_fix = clear_winfixbuf

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

		-- Inline variable values at breakpoints
		require("nvim-dap-virtual-text").setup()

		-- Setup Go debugging with delve
		require("dap-go").setup()
	end,
}
