local gh = require("utils.gh")

return {
	specs = { gh("benlubas/molten-nvim") },
	init = function()
		-- IMPORTANT: Must be set FIRST before other settings
		vim.g.molten_use_border_highlights = true

		vim.g.molten_output_win_max_height = 20
		vim.g.molten_auto_open_output = true -- Auto-open to see borders
		vim.g.molten_wrap_output = true
		vim.g.molten_output_win_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
		vim.g.molten_output_crop_border = true
		vim.g.molten_output_show_more = true -- Show "x more lines" (nvim 10.0+)
		vim.g.molten_output_virt_lines = true -- Pad with virtual lines so float doesn't cover content
		vim.g.molten_enter_output_behavior = "open_then_enter"

		vim.g.molten_virt_text_output = true
		vim.g.molten_virt_text_max_lines = 12
		vim.g.molten_virt_lines_off_by_1 = true

		vim.g.molten_image_provider = "snacks.nvim"
		vim.g.molten_image_location = "float"
		vim.g.molten_output_win_zindex = 100

		vim.g.molten_cover_empty_lines = false
		vim.g.molten_output_show_exec_time = true
	end,
	setup = function()
		local function setup_highlights()
			local ok, palette = pcall(require, "catppuccin.palettes")
			if not ok then
				vim.notify("Catppuccin not loaded yet", vim.log.levels.WARN)
				return
			end

			local colors = palette.get_palette("mocha")

			vim.api.nvim_set_hl(0, "MoltenOutputBorder", { fg = colors.lavender, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { fg = colors.red, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenOutputBorderSuccess", { fg = colors.green, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenOutputWin", { fg = colors.text, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenOutputWinNC", { fg = colors.overlay1, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenOutputFooter", { fg = colors.overlay0, bg = "NONE" })
			vim.api.nvim_set_hl(0, "MoltenCell", { bg = colors.surface0 })
			vim.api.nvim_set_hl(0, "MoltenVirtualText", { fg = colors.overlay0, italic = true })
		end

		-- Apply highlights on colorscheme changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.defer_fn(setup_highlights, 50)
			end,
		})

		vim.keymap.set("n", "<localleader>mi", "<cmd>MoltenInit<cr>", { desc = "Initialize Molten" })
		vim.keymap.set("n", "<localleader>me", "<cmd>MoltenEvaluateOperator<cr>", { desc = "Evaluate operator" })
		vim.keymap.set("n", "<localleader>ml", "<cmd>MoltenEvaluateLine<cr>", { desc = "Evaluate line" })
		vim.keymap.set("n", "<localleader>mr", "<cmd>MoltenReevaluateCell<cr>", { desc = "Re-evaluate cell" })
		vim.keymap.set("n", "<localleader>md", "<cmd>MoltenDelete<cr>", { desc = "Delete cell" })
		vim.keymap.set("n", "<localleader>mo", "<cmd>MoltenShowOutput<cr>", { desc = "Show output" })
		vim.keymap.set("n", "<localleader>mh", "<cmd>MoltenHideOutput<cr>", { desc = "Hide output" })
		vim.keymap.set("n", "<localleader>mx", "<cmd>MoltenInterrupt<cr>", { desc = "Interrupt kernel" })
		vim.keymap.set("n", "<localleader>mc", "<cmd>noautocmd MoltenEnterOutput<cr>", { desc = "Enter output window" })
		vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<cr>", { desc = "Evaluate selection" })

		-- Run code block under cursor in markdown
		vim.keymap.set("n", "<localleader>mb", function()
			local node = vim.treesitter.get_node()
			while node do
				if node:type() == "fenced_code_block" then
					for child in node:iter_children() do
						if child:type() == "code_fence_content" then
							local start_row, _, end_row, _ = child:range()
							local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row, false)
							local code = table.concat(lines, "\n")
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
