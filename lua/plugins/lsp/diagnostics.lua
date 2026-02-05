-- lsp_lines: show diagnostics as virtual lines below code
return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = "LspAttach",
	config = function()
		require("lsp_lines").setup()

		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = { only_current_line = true },
		})

		vim.keymap.set("n", "<leader>ud", function()
			local config = vim.diagnostic.config()
			local vl = config.virtual_lines
			-- Check if it's a table with only_current_line set
			if type(vl) == "table" and vl.only_current_line then
				vim.diagnostic.config({ virtual_lines = true })
				vim.notify("lsp_lines: all lines", vim.log.levels.INFO)
			else
				vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
				vim.notify("lsp_lines: current line only", vim.log.levels.INFO)
			end
		end, { desc = "Toggle lsp_lines current line" })
	end,
}
