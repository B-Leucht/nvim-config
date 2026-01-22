-- Autocompletion with blink.cmp
return {
	"saghen/blink.cmp",
	version = "*",
	-- event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- copilot.lua is configured separately in plugins/editor/copilot.lua
		"giuxtaposition/blink-cmp-copilot",
	},
	opts = {
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
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
					columns = { { "kind_icon" }, { "label" } },
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
			default = { "lsp", "path", "snippets", "buffer", "copilot", "lazydev" },
			providers = {
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
			},
		},
	},
}
