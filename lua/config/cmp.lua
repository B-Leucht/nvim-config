local cmp = require("cmp")
local lsp = vim.lsp
local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		-- Group 1: Primary sources (highest priority)
		{ name = "nvim_lsp", priority = 1000 },
		{ name = "nvim_lsp_signature_help", priority = 900 },
		{ name = "luasnip", priority = 800 },
		{ name = "copilot", priority = 700 },
	}, {
		-- Group 2: Secondary sources
		{ name = "buffer", priority = 500, max_item_count = 5, keyword_length = 3 },
		{ name = "path", priority = 400, max_item_count = 5 },
		{
			name = "nvim_lua",
			priority = 300,
			max_item_count = 5,
			entry_filter = function()
				return vim.bo.filetype == "lua"
			end,
		},
	}, {
		-- Group 3: Fallback sources (lowest priority)
		{ name = "git", priority = 200, max_item_count = 3 },
		{
			name = "treesitter",
			priority = 150,
			max_item_count = 3,
			keyword_length = 4,
			entry_filter = function(entry, vim_item)
				if entry.kind == 15 then
					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					local line = vim.api.nvim_get_current_line()
					local next_char = line:sub(cursor_pos[2] + 1, cursor_pos[2] + 1)
					if next_char == '"' or next_char == "'" then
						vim_item.abbr = vim_item.abbr:sub(1, -2)
					end
				end
				return vim_item
			end,
		},
		{
			name = "rg",
			priority = 100,
			keyword_length = 6,
			max_item_count = 3,
			option = {
				additional_arguments = "--smart-case --hidden",
			},
		},
		{ name = "calc", priority = 50, max_item_count = 3 },
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			maxwidth = {
				menu = function()
					return math.floor(0.45 * vim.o.columns)
				end,
				abbr = 50, -- actual suggestion item
			},
			mode = "symbol", -- show symbol + text
			ellipsis_char = "...",
			symbol_map = {
				Copilot = "",
				-- add other kinds here if customizing
			},
		}),
	},
})
require("cmp_git").setup()
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

