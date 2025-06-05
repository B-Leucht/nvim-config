local cmp = require("cmp")
local lsp = vim.lsp
local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
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
