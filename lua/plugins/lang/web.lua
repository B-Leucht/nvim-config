return {
	-- Inline color highlighting (hex, rgb, hsl, named colors, tailwind)
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "virtual",
			virtual_symbol = "■",
			enable_named_colors = true,
			enable_tailwind = true,
		},
	},

	-- Tailwind CSS colorizer and sorter
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
		opts = {
			server = { override = false, setup = false },
		},
	},

	-- Emmet support via LSP
	{
		"olrtg/nvim-emmet",
		ft = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
		keys = {
			{
				"<leader>xe",
				function()
					require("nvim-emmet").wrap_with_abbreviation()
				end,
				desc = "Emmet Wrap with Abbreviation",
				mode = { "n", "v" },
			},
		},
		config = function() end,
	},

	-- package.json dependency management
	{
		"vuki656/package-info.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		ft = "json",
		opts = {},
		keys = {
			{ "<leader>ps", function() require("package-info").show() end, desc = "Show Package Info", ft = "json" },
			{ "<leader>ph", function() require("package-info").hide() end, desc = "Hide Package Info", ft = "json" },
			{ "<leader>pu", function() require("package-info").update() end, desc = "Update Package", ft = "json" },
			{ "<leader>pd", function() require("package-info").delete() end, desc = "Delete Package", ft = "json" },
			{ "<leader>pi", function() require("package-info").install() end, desc = "Install Package", ft = "json" },
			{ "<leader>pc", function() require("package-info").change_version() end, desc = "Change Version", ft = "json" },
		},
	},
}
