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
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
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
-- Show hover doc on completion selection change
cmp.event:on("menu_changed", function(event)
	local entry = event.entry
	if not entry then
		return
	end

	local item = entry:get_completion_item()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Use lspsaga hover doc for the selected item word
	local word = item.label or ""
	if word ~= "" then
		-- Use lspsaga to show hover doc at cursor position
		-- You might want to debounce this if flickering happens
		require("lspsaga.hover").render_hover_doc({ data = nil, title = word, max_width = 60 })
	end
end)
