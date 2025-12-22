-- Autocompletion
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-calc" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{
			"lukas-reineke/cmp-rg",
			enabled = function()
				return vim.fn.executable("rg") == 1
			end,
		},
		{ "SergioRibera/cmp-dotenv" },
		{ "davidsierradz/cmp-conventionalcommits" },
		{ "petertriho/cmp-git" },
		{ "saadparwaiz1/cmp_luasnip" },
		{
			"zbirenbaum/copilot-cmp",
			config = function()
				require("copilot_cmp").setup()
			end,
		},
	},
	config = function()
		local constants = require("core.constants")
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = {
				autocomplete = { -- Auto-trigger completion
					require("cmp.types").cmp.TriggerEvent.TextChanged,
				},
			},
			performance = {
				debounce = 60, -- Faster debounce (default 60ms)
				throttle = 30, -- Faster throttle (default 30ms)
				fetching_timeout = 200, -- Faster timeout (default 500ms)
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
					winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- experimental = {
			-- 	ghost_text = {
			-- 		hl_group = "CmpGhostText",
			-- 	},
			-- },
			sources = cmp.config.sources({
				{ name = "copilot", priority = 1100, max_item_count = 3 },
				{
					name = "lazydev",
					priority = 1000,
				},
				{ name = "nvim_lsp", priority = 900 },
				{ name = "nvim_lsp_signature_help", priority = 950 },
				{ name = "luasnip", priority = 800 },
			}, {
				{ name = "buffer", priority = 700, max_item_count = 5, keyword_length = 3 },
				{ name = "path", priority = 600, max_item_count = 5 },
				{
					name = "nvim_lua",
					priority = 500,
					max_item_count = 5,
					entry_filter = function()
						return vim.bo.filetype == "lua"
					end,
				},
			}, {
				{ name = "git", priority = 200, max_item_count = 3 },
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
				fields = { "abbr", "kind", "menu" },
				format = require("lspkind").cmp_format({
					maxwidth = {
						menu = function()
							return math.floor(0.45 * vim.o.columns)
						end,
						abbr = 50,
					},
					mode = "symbol", -- Only show icon, not icon + text
					ellipsis_char = "...",
					show_labelDetails = false, -- Disable to avoid icon duplication
					symbol_map = {
						Copilot = "",
						-- add other kinds here if customizing
					},
				}),
			},
		})
		require("cmp_git").setup()

		-- Command line setup for search
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer", max_item_count = 5 },
			},
		})

		-- -- Command line setup for commands
		-- cmp.setup.cmdline(":", {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "path" },
		-- 	}, {
		-- 		{ name = "cmdline" },
		-- 	}),
		-- })
	end,
}
