return {
	-- Enhanced C/C++ development with Address Sanitizer support
	{
		"p00f/clangd_extensions.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		config = function()
			require("clangd_extensions").setup({
				extensions = {
					-- Enable inlay hints
					inlay_hints = {
						only_current_line = false,
						only_current_line_autocmd = "CursorHold",
						show_parameter_hints = true,
						parameter_hints_prefix = "<- ",
						other_hints_prefix = "=> ",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
					},
					-- Enable AST viewer
					ast = {
						role_icons = {
							type = "",
							declaration = "",
							expression = "",
							specifier = "",
							statement = "",
							["template argument"] = "",
						},
					},
				},
			})
		end,
	},

	-- Address Sanitizer integration
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			spec = {
				{ "<leader>a", group = "Address Sanitizer" },
			},
		},
	},

	-- Custom Address Sanitizer commands
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- Address Sanitizer build configurations
			local asan_flags = {
				gcc = {
					"-fsanitize=address",
					"-fno-omit-frame-pointer",
					"-g",
					"-O1",
				},
				clang = {
					"-fsanitize=address",
					"-fno-omit-frame-pointer",
					"-g",
					"-O1",
					"-fsanitize-address-use-after-scope",
				},
			}

			-- Additional sanitizer options
			local sanitizer_flags = {
				memory = {
					gcc = { "-fsanitize=memory", "-fno-omit-frame-pointer", "-g", "-O1" },
					clang = { "-fsanitize=memory", "-fno-omit-frame-pointer", "-g", "-O1" },
				},
				thread = {
					gcc = { "-fsanitize=thread", "-g", "-O1" },
					clang = { "-fsanitize=thread", "-g", "-O1" },
				},
				undefined = {
					gcc = { "-fsanitize=undefined", "-g", "-O1" },
					clang = { "-fsanitize=undefined", "-g", "-O1" },
				},
			}

			-- Function to detect compiler (prioritize gcc for exam)
			local function detect_compiler()
				if vim.fn.executable("gcc") == 1 then
					return "gcc"
				elseif vim.fn.executable("clang") == 1 then
					return "clang"
				else
					return nil
				end
			end

			-- Function to build with sanitizer
			local function build_with_sanitizer(sanitizer_type, extra_args)
				local compiler = detect_compiler()
				if not compiler then
					vim.notify("No C compiler found (gcc/clang)", vim.log.levels.ERROR)
					return
				end

				local flags
				if sanitizer_type == "address" then
					flags = asan_flags[compiler]
				else
					flags = sanitizer_flags[sanitizer_type] and sanitizer_flags[sanitizer_type][compiler]
				end

				if not flags then
					vim.notify("Unsupported sanitizer: " .. sanitizer_type, vim.log.levels.ERROR)
					return
				end

				local current_file = vim.fn.expand("%:p")
				local output_file = vim.fn.expand("%:r") .. "_" .. sanitizer_type

				local cmd = table.concat({
					compiler,
					table.concat(flags, " "),
					extra_args or "",
					current_file,
					"-o",
					output_file,
				}, " ")

				vim.notify("Building with " .. sanitizer_type .. " sanitizer: " .. cmd)
				vim.cmd("!" .. cmd)
			end

			-- Function to run with ASan environment
			local function run_with_asan()
				local executable = vim.fn.expand("%:r") .. "_address"
				if vim.fn.executable(executable) ~= 1 then
					vim.notify("Executable not found: " .. executable .. ". Build with ASan first.", vim.log.levels.ERROR)
					return
				end

				-- Set ASan environment variables
				local asan_options = {
					"ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:detect_leaks=1:check_initialization_order=1:strict_init_order=1",
				}

				local cmd = table.concat(asan_options, " ") .. " ./" .. executable
				vim.notify("Running with ASan: " .. cmd)
				vim.cmd("!" .. cmd)
			end

			-- Function to parse ASan output and create quickfix
			local function parse_asan_output()
				local qf_list = {}
				local lines = vim.fn.systemlist("cat /tmp/asan_output 2>/dev/null || echo 'No ASan output found'")

				for _, line in ipairs(lines) do
					-- Parse ASan error format: filename:line:column: error message
					local filename, line_num, col_num, msg = line:match("^([^:]+):(%d+):(%d*):?%s*(.*)$")
					if filename and line_num and msg then
						table.insert(qf_list, {
							filename = filename,
							lnum = tonumber(line_num),
							col = tonumber(col_num) or 1,
							text = msg,
							type = "E",
						})
					end
				end

				if #qf_list > 0 then
					vim.fn.setqflist(qf_list)
					vim.cmd("copen")
					vim.notify("ASan errors loaded into quickfix list")
				else
					vim.notify("No ASan errors found")
				end
			end

			-- Create commands for C/C++ files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "cpp" },
				callback = function(args)
					local opts = { buffer = args.buf }

					-- Address Sanitizer commands
					vim.keymap.set("n", "<leader>abb", function()
						build_with_sanitizer("address")
					end, vim.tbl_extend("force", opts, { desc = "Build with AddressSanitizer" }))

					vim.keymap.set("n", "<leader>abr", run_with_asan, vim.tbl_extend("force", opts, { desc = "Run with AddressSanitizer" }))

					vim.keymap.set("n", "<leader>abo", parse_asan_output, vim.tbl_extend("force", opts, { desc = "Parse ASan Output" }))

					-- Other sanitizers
					vim.keymap.set("n", "<leader>amb", function()
						build_with_sanitizer("memory")
					end, vim.tbl_extend("force", opts, { desc = "Build with MemorySanitizer" }))

					vim.keymap.set("n", "<leader>atb", function()
						build_with_sanitizer("thread")
					end, vim.tbl_extend("force", opts, { desc = "Build with ThreadSanitizer" }))

					vim.keymap.set("n", "<leader>aub", function()
						build_with_sanitizer("undefined")
					end, vim.tbl_extend("force", opts, { desc = "Build with UBSanitizer" }))

					-- Quick build and run
					vim.keymap.set("n", "<leader>abR", function()
						build_with_sanitizer("address")
						vim.defer_fn(run_with_asan, 1000)
					end, vim.tbl_extend("force", opts, { desc = "Build and Run with ASan" }))

					-- Custom build with extra flags
					vim.keymap.set("n", "<leader>abc", function()
						local extra_flags = vim.fn.input("Extra compiler flags: ")
						build_with_sanitizer("address", extra_flags)
					end, vim.tbl_extend("force", opts, { desc = "Build with ASan + Custom Flags" }))

					-- Simple gcc compile for exam (no sanitizers)
					vim.keymap.set("n", "<leader>cb", function()
						local file = vim.fn.expand("%")
						local output = vim.fn.expand("%:r")
						local cmd = "gcc -Wall -Wextra -std=c99 " .. file .. " -o " .. output
						vim.notify("Compiling with gcc: " .. cmd)
						vim.cmd("!" .. cmd)
					end, vim.tbl_extend("force", opts, { desc = "Simple GCC compile" }))
				end,
			})

			-- Auto-parse ASan output on build
			vim.api.nvim_create_autocmd("ShellCmdPost", {
				callback = function()
					if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
						vim.defer_fn(function()
							if vim.fn.filereadable("/tmp/asan_output") == 1 then
								parse_asan_output()
							end
						end, 500)
					end
				end,
			})
		end,
	},
}