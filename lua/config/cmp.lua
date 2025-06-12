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
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "copilot" },
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			maxwidth = {
				-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				-- can also be a function to dynamically calculate max width such as
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
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" },
	}, {
		{ name = "buffer" },
	}),
})
require("cmp_git").setup()
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})
-- Show hover doc on completion selection change
cmp.event:on("menu_changed", function(event)
	local entry = event.entry
	if not entry then
		return
	end

	local item = entry:get_completion_item()

	-- Use lspsaga hover doc for the selected item word
	local word = item.label or ""
	if word ~= "" then
		vim.lsp.buf.hover()
	end
end)
