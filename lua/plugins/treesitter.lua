local gh = require("utils.gh")

return {
	specs = {
		gh("nvim-treesitter/nvim-treesitter"),
		gh("nvim-treesitter/nvim-treesitter-context"),
	},
	setup = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = function()
				require("nvim-treesitter.parsers").asciidoc = {
					install_info = {
						branch = "master",
						location = "tree-sitter-asciidoc",
						queries = "queries/asciidoc/",
						requires = { "asciidoc_inline" },
						url = "https://github.com/cathaysia/tree-sitter-asciidoc",
					},
				}
				require("nvim-treesitter.parsers").asciidoc_inline = {
					install_info = {
						branch = "master",
						location = "tree-sitter-asciidoc_inline",
						queries = "queries/asciidoc_inline",
						url = "https://github.com/cathaysia/tree-sitter-asciidoc",
					},
				}
				require("nvim-treesitter.parsers").comment = {
					install_info = {
						url = "https://github.com/OXY2DEV/tree-sitter-comment",
						branch = "main",
						queries = "queries/",
					},
				}
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})

		require("treesitter-context").setup({
			max_lines = 3,
			min_window_height = 20,
		})

		vim.keymap.set("n", "<leader>uc", function()
			require("treesitter-context").toggle()
		end, { desc = "Toggle Treesitter Context" })
	end,
}
