return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"Kaiser-Yang/blink-cmp-dictionary",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		"Kaiser-Yang/blink-cmp-git",
		"disrupted/blink-cmp-conventional-commits",
	},
	opts = {
		keymap = {
			preset = "default",
			["<C-d>"] = { "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = {
				"snippet_forward",
				function()
					return require("sidekick").nes_jump_or_apply()
				end,
				"fallback",
			},
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
			kind_icons = {
				claude = "󰋦",
				openai = "󱢆",
				codestral = "󱎥",
				gemini = "",
				Groq = "",
				Openrouter = "󱂇",
				Ollama = "󰳆",
				["Llama.cpp"] = "󰳆",
				Deepseek = "",
			},
		},

		completion = {
			accept = {
				auto_brackets = { enabled = false },
			},
			trigger = { prefetch_on_insert = false },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					winblend = 0,
					scrollbar = false,
					max_width = 60,
					max_height = 12,
				},
			},
			menu = {
				border = "rounded",
				winblend = 0,
				max_height = 12,
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
				draw = {
					columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
				},
			},
			ghost_text = { enabled = false },
		},

		signature = {
			enabled = true,
			window = {
				border = "rounded",
				winblend = 0,
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "dictionary", "lazydev", "git", "minuet", "conventional_commits" },
			providers = {
				lsp = {
					score_offset = 100,
				},
				buffer = {
					score_offset = 20,
				},
				snippets = {
					score_offset = 30,
				},
					lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				dictionary = {
					name = "Dict",
					module = "blink-cmp-dictionary",
					score_offset = 25,
					max_items = 3,
					opts = {
						dictionary_files = {
							vim.fn.stdpath("config") .. "/dict/english.txt",
							vim.fn.stdpath("config") .. "/dict/german.txt",
							vim.fn.stdpath("config") .. "/dict/personal.txt",
							vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
						},
						min_keyword_length = 3,
						get_documentation = function(item)
							return {
								get_command = function()
									return vim.fn.executable("wn-de") == 1 and "wn-de" or ""
								end,
								get_command_args = function()
									return { item }
								end,
								resolve_documentation = function(output)
									return output
								end,
								on_error = function()
									return false
								end,
							}
						end,
					},
				},
				git = {
					name = "Git",
					module = "blink-cmp-git",
					score_offset = 150,
				},
				minuet = {
					name = "Minuet",
					module = "minuet.blink",
					async = true,
					timeout_ms = 3000,
					score_offset = 50,
				},
				conventional_commits = {
					name = "Commits",
					module = "blink-cmp-conventional-commits",
					score_offset = 200,
				},
			},
		},
		cmdline = {
			enabled = false,
		},
		fuzzy = {
			sorts = {
				function(a, b)
					local sort = require("blink.cmp.fuzzy.sort")
					if a.source_id == "spell" and b.source_id == "spell" then
						return sort.label(a, b)
					end
				end,
				"score",
				"kind",
				"label",
			},
		},
	},
}
