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

			-- Gradle wrapper detection
			local function find_gradle_wrapper(fname)
				return vim.fs.find("gradlew", {
					path = fname,
					upward = true,
				})[1]
			end

			-- Spring Boot project detection
			local function is_spring_boot_project(root_dir)
				local spring_indicators = {
					"src/main/resources/application.properties",
					"src/main/resources/application.yml",
					"src/main/resources/application.yaml",
				}
				for _, indicator in ipairs(spring_indicators) do
					if vim.fn.filereadable(root_dir .. "/" .. indicator) == 1 then
						return true
					end
				end
				return false
			end

			local function get_jdtls_config()
				local home = os.getenv("HOME")
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

				local launcher_jar = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
				if launcher_jar == "" then
					vim.notify("JDTLS launcher jar not found. Install jdtls via Mason.", vim.log.levels.ERROR)
					return
				end

				local config = {
					cmd = {
						"/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home/bin/java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xms1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens", "java.base/java.util=ALL-UNNAMED",
						"--add-opens", "java.base/java.lang=ALL-UNNAMED",
						"-jar", launcher_jar,
						"-configuration", vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_mac",
						"-data", workspace_dir,
					},
					root_dir = jdtls_setup.find_root({ ".git", "mvnw", "gradlew", "build.gradle", "pom.xml" }),
					settings = {
						java = {
							eclipse = {
								downloadSources = true,
							},
							configuration = {
								updateBuildConfiguration = "interactive",
								runtimes = {
									{
										name = "JavaSE-17",
										path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
									},
									{
										name = "JavaSE-24",
										path = "/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home",
									},
								},
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
							vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
							vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", true),
						},
					},
					on_attach = function(client, bufnr)
						jdtls_setup.add_commands()
						
						-- Enable inlay hints
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end

						-- Java debugging
						jdtls.setup_dap({ hotcodereplace = "auto" })
						
						-- Enhanced keymaps
						vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, { desc = "Organize Imports", buffer = bufnr })
						vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, { desc = "Extract Variable", buffer = bufnr })
						vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, { desc = "Extract Constant", buffer = bufnr })
						vim.keymap.set("v", "<leader>jm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], { desc = "Extract Method", buffer = bufnr })
						vim.keymap.set("n", "<leader>jt", jdtls.test_class, { desc = "Test Class", buffer = bufnr })
						vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, { desc = "Test Nearest Method", buffer = bufnr })

						-- Gradle-specific keymaps
						local gradle_wrapper = find_gradle_wrapper(vim.fn.expand("%:p"))
						if gradle_wrapper then
							vim.keymap.set("n", "<leader>gb", function()
								vim.cmd("!./gradlew build")
							end, { desc = "Gradle Build", buffer = bufnr })

							vim.keymap.set("n", "<leader>gt", function()
								vim.cmd("!./gradlew test")
							end, { desc = "Gradle Test", buffer = bufnr })

							vim.keymap.set("n", "<leader>gr", function()
								vim.cmd("!./gradlew bootRun")
							end, { desc = "Gradle Boot Run", buffer = bufnr })
						end

						-- Spring Boot specific keymaps
						local root_dir = jdtls_setup.find_root({ ".git", "mvnw", "gradlew", "build.gradle", "pom.xml" })
						if is_spring_boot_project(root_dir) then
							vim.keymap.set("n", "<leader>sb", function()
								vim.cmd("!./gradlew bootRun")
							end, { desc = "Spring Boot Run", buffer = bufnr })
						end
						
						-- Toggle inlay hints
						vim.keymap.set("n", "<leader>uh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
						end, { desc = "Toggle Inlay Hints", buffer = bufnr })
					end,
				}

				return config
			end

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

