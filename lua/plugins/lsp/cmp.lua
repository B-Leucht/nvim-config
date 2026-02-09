return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"giuxtaposition/blink-cmp-copilot",
		{
			"Kaiser-Yang/blink-cmp-dictionary",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		"Kaiser-Yang/blink-cmp-git",
	},
	opts = {
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
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
		},

		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					winblend = 0,
					scrollbar = false,
				},
			},
			menu = {
				border = "rounded",
				winblend = 0,
				winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
				draw = {
					columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
			ghost_text = {
				enabled = false,
			},
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
			default = { "lsp", "path", "snippets", "buffer", "copilot", "dictionary", "lazydev", "git" },
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
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
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
