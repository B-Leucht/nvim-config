local gh = require("utils.gh")

return {
	specs = { gh("folke/which-key.nvim") },
	setup = function()
		local wk = require("which-key")
		wk.setup({
			preset = "helix",
			win = {
				border = "rounded",
				wo = {
					winblend = 0,
				},
			},
		})
		wk.add({
			{ "<leader>a", group = "ai" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>d", group = "debug" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "haskell", icon = "󰲒" },
			{ "<leader>j", group = "java", icon = "󰬷" },
			{ "<leader>r", group = "rust", icon = "󱘗" },
			{
				"<leader>l",
				group = "lsp",
				icon = function()
					local icon = MiniIcons.get("filetype", vim.bo.filetype)
					return icon
				end,
			},
			{ "<leader>c", group = "code", icon = "" },
			{ "<leader>m", group = "molten", icon = "" },
			{ "<leader>M", group = "makros", icon = "" },
			{ "<leader>O", group = "overseer", icon = "" },
			{ "<leader>e", group = "conjure", icon = "" },
			{ "<leader>el", group = "log", icon = "" },
			{ "<leader>t", group = "terminal" },
			{ "<leader>T", group = "neotest" },
			{ "<leader>n", group = "notes", icon = "󰎜" },
			{ "<leader>o", group = "obsidian", icon = "󰧑" },
			{ "<leader>p", group = "web", icon = "󰖟" },
			{ "<leader>s", group = "search" },
			{ "<leader>u", group = "ui" },
			{ "<leader>v", group = "vimtex", icon = "" },
			{ "<leader>w", group = "windows" },
		})
	end,
}
