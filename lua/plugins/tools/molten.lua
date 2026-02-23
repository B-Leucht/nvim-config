-- Jupyter-like code execution in Neovim
return {
	"benlubas/molten-nvim",
	ft = { "python", "markdown", "quarto" },
	build = ":UpdateRemotePlugins",
	dependencies = {
		"folke/snacks.nvim",
	},
	keys = {
		{ "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Initialize Molten" },
		{ "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", desc = "Evaluate operator" },
		{ "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Evaluate line" },
		{ "<leader>mr", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-evaluate cell" },
		{ "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Delete cell" },
		{ "<leader>mo", "<cmd>MoltenShowOutput<cr>", desc = "Show output", ft = { "python", "markdown", "quarto" } },
		{ "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Hide output" },
		{ "<leader>mx", "<cmd>MoltenInterrupt<cr>", desc = "Interrupt kernel" },
		{ "<leader>mc", "<cmd>noautocmd MoltenEnterOutput<cr>", desc = "Enter output window" },
		{ "<leader>r", ":<C-u>MoltenEvaluateVisual<cr>", desc = "Evaluate selection", mode = "v" },
	},
	init = function()
		-- Border highlights (colored borders for success/fail)
		-- IMPORTANT: Must be set FIRST before other settings
		vim.g.molten_use_border_highlights = true

		-- Output window settings
		vim.g.molten_output_win_max_height = 20
		vim.g.molten_auto_open_output = true -- Auto-open to see borders
		vim.g.molten_wrap_output = true
		-- Border must be specified as table for highlights to work
		vim.g.molten_output_win_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		vim.g.molten_output_crop_border = true
		vim.g.molten_output_show_more = true -- Show "x more lines" (nvim 10.0+)
		vim.g.molten_output_virt_lines = true -- Pad with virtual lines so float doesn't cover content
		vim.g.molten_enter_output_behavior = "open_then_enter"

		vim.g.molten_virt_text_output = true
		vim.g.molten_virt_text_max_lines = 12
		vim.g.molten_virt_lines_off_by_1 = true

		-- Image settings
		vim.g.molten_image_provider = "snacks.nvim"
		vim.g.molten_image_location = "float"
		vim.g.molten_output_win_zindex = 100

		-- Misc
		vim.g.molten_cover_empty_lines = false
		vim.g.molten_output_show_exec_time = true
	end,
	config = function()
		-- Setup Molten highlights to match Catppuccin theme
		local function setup_highlights()
			-- Use pcall to safely get colors
			local ok, palette = pcall(require, "catppuccin.palettes")
			if not ok then
				vim.notify("Catppuccin not loaded yet", vim.log.levels.WARN)
				return
			end

			local colors = palette.get_palette("mocha")

			-- Style Molten to match theme
			-- Default border (lavender)
			vim.api.nvim_set_hl(0, "MoltenOutputBorder", { fg = colors.lavender, bg = "NONE" })
			-- Failed execution border (red)
			vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { fg = colors.red, bg = "NONE" })
			-- Successful execution border (green)
			vim.api.nvim_set_hl(0, "MoltenOutputBorderSuccess", { fg = colors.green, bg = "NONE" })
			-- Output window content
			vim.api.nvim_set_hl(0, "MoltenOutputWin", { fg = colors.text, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenOutputWinNC", { fg = colors.overlay1, bg = "NONE" })
			-- Footer text
			vim.api.nvim_set_hl(0, "MoltenOutputFooter", { fg = colors.overlay0, bg = "NONE" })
			-- Cell background
			vim.api.nvim_set_hl(0, "MoltenCell", { bg = colors.surface0 })
			-- Virtual text output
			vim.api.nvim_set_hl(0, "MoltenVirtualText", { fg = colors.overlay0, italic = true })
		end

		-- Apply highlights on colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.defer_fn(setup_highlights, 50)
			end,
		})

-- Run code block under cursor in markdown
		vim.keymap.set("n", "<leader>mb", function()
			local node = vim.treesitter.get_node()
			while node do
				if node:type() == "fenced_code_block" then
					-- Find the code_fence_content child
					for child in node:iter_children() do
						if child:type() == "code_fence_content" then
							local start_row, _, end_row, _ = child:range()
							-- Get the text content
							local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row, false)
							local code = table.concat(lines, "\n")
							-- Use MoltenEvaluateArgument to run the code
							vim.cmd("MoltenEvaluateArgument " .. vim.fn.shellescape(code))
							return
						end
					end
				end
				node = node:parent()
			end
			print("Not inside a code block")
		end, { desc = "Evaluate code block" })
	end,
}
