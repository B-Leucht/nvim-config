require("fzf-lua").setup({})

vim.ui.select = function(items, opts, on_choice)
	local fzf = require("fzf-lua")
	fzf.fzf_select(items, {
		prompt = opts.prompt or "Select one",
		format_item = opts.format_item or tostring,
	}, on_choice)
end

vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>", { desc = "Find files", silent = true })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep", silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Buffers", silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua help_tags<CR>", { desc = "Help tags", silent = true })
vim.keymap.set("n", "<leader>r", "<cmd>FzfLua resume<CR>", { desc = "Resume", silent = true })
