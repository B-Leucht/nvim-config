-- Mini.nvim collection
return {
	"echasnovski/mini.nvim",
	version = false,
	event = "VeryLazy",
	config = function()
		-- mini.comment removed - using ts-comments.nvim for better treesitter-aware commenting
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.icons").setup()
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {
					add = "│",
					change = "│",
					delete = "_",
				},
			},
		})
		Snacks.keymap.set("n", "<leader>gD", MiniDiff.toggle_overlay, { desc = "Toggle diff overlay" })

		-- Enhanced text objects (vaq = around quotes, vab = around brackets, etc.)
		require("mini.ai").setup({
			n_lines = 500,
		})

		-- Move lines/selections with Alt+hjkl
		require("mini.move").setup({
			mappings = {
				left = "<A-h>",
				right = "<A-l>",
				down = "<A-j>",
				up = "<A-k>",
				line_left = "<A-h>",
				line_right = "<A-l>",
				line_down = "<A-j>",
				line_up = "<A-k>",
			},
		})

		-- Toggle single/multiline (gS to split, gJ to join)
		require("mini.splitjoin").setup()

		-- Bracketed navigation ([b/]b for buffers, [d/]d for diagnostics, etc.)
		require("mini.bracketed").setup()

		-- Session management
		require("mini.sessions").setup({
			autoread = false,
			autowrite = true,
			directory = vim.fn.stdpath("state") .. "/sessions/",
		})

		MiniIcons.mock_nvim_web_devicons()
	end,
}