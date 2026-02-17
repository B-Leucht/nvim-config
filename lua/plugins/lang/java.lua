return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local jdtls = require("jdtls")
			local jdtls_setup = require("jdtls.setup")

			local function get_jdtls_config()
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				local workspace_dir = vim.fn.expand("~/.local/share/eclipse/") .. project_name

				local launcher_jar = vim.fn.glob(
					vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
				)
				if launcher_jar == "" then
					vim.notify("JDTLS launcher jar not found. Install jdtls via Mason.", vim.log.levels.ERROR)
					return
				end

				-- Auto-detect OS config folder
				local config_dir = "config_linux"
				if vim.fn.has("mac") == 1 then
					config_dir = "config_mac"
				elseif vim.fn.has("win32") == 1 then
					config_dir = "config_win"
				end

				-- Build runtimes from environment variables if available
				local runtimes = {}
				if os.getenv("JAVA21_HOME") then
					table.insert(runtimes, { name = "JavaSE-21", path = os.getenv("JAVA21_HOME") })
				end

				local config = {
					cmd = {
						"java", -- Uses system PATH
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Xms1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"-jar",
						launcher_jar,
						"-configuration",
						vim.fn.stdpath("data") .. "/mason/packages/jdtls/" .. config_dir,
						"-data",
						workspace_dir,
					},
					root_dir = jdtls_setup.find_root({ ".git", "mvnw", "gradlew", "build.gradle", "pom.xml" }),
					settings = {
						java = {
							eclipse = {
								downloadSources = true,
							},
							configuration = {
								updateBuildConfiguration = "interactive",
								runtimes = runtimes, -- Uses JAVA21_HOME env var if set
							},
							maven = {
								downloadSources = true,
							},
							implementationsCodeLens = {
								enabled = true,
							},
							referencesCodeLens = {
								enabled = true,
							},
							references = {
								includeDecompiledSources = true,
							},
							format = {
								enabled = true,
							},
							inlayHints = {
								parameterNames = {
									enabled = "all",
								},
							},
						},
						signatureHelp = { enabled = true },
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
								"org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
								"org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
					},
					init_options = {
						bundles = {
							vim.fn.glob(
								vim.fn.stdpath("data")
									.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
								true
							),
							vim.fn.glob(
								vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar",
								true
							),
						},
					},
					on_attach = function(_, bufnr)
						jdtls_setup.add_commands()

						-- Java debugging
						jdtls.setup_dap({ hotcodereplace = "auto" })

						-- Enhanced keymaps
						vim.keymap.set(
							"n",
							"<leader>jo",
							jdtls.organize_imports,
							{ desc = "Organize Imports", buffer = bufnr }
						)
						vim.keymap.set(
							"n",
							"<leader>jv",
							jdtls.extract_variable,
							{ desc = "Extract Variable", buffer = bufnr }
						)
						vim.keymap.set(
							"n",
							"<leader>jc",
							jdtls.extract_constant,
							{ desc = "Extract Constant", buffer = bufnr }
						)
						vim.keymap.set(
							"v",
							"<leader>jm",
							[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
							{ desc = "Extract Method", buffer = bufnr }
						)
						vim.keymap.set("n", "<leader>jt", jdtls.test_class, { desc = "Test Class", buffer = bufnr })
						vim.keymap.set(
							"n",
							"<leader>jn",
							jdtls.test_nearest_method,
							{ desc = "Test Nearest Method", buffer = bufnr }
						)

						-- Toggle inlay hints
						vim.keymap.set("n", "<leader>uh", function()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
								{ bufnr = bufnr }
							)
						end, { desc = "Toggle Inlay Hints", buffer = bufnr })
					end,
				}

				return config
			end

			-- Start jdtls immediately if we're in a Java buffer
			local config = get_jdtls_config()
			if config then
				jdtls.start_or_attach(config)
			end

			-- Also set up autocmd for future Java buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local config = get_jdtls_config()
					if config then
						jdtls.start_or_attach(config)
					end
				end,
			})
		end,
	},
}
