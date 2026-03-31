local gh = function(x) return "https://github.com/" .. x end

return {
	specs = {
		gh("folke/noice.nvim"),
		gh("MunifTanjim/nui.nvim"),
	},
	setup = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
			messages = {
				enabled = true,
				view = "mini",
				view_error = "notify",
				view_warn = "mini",
				view_history = "messages",
				view_search = false,
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			lsp = {
				progress = {
					enabled = false,
				},
				signature = { enabled = false },
				hover = {
					enabled = true,
					view = nil,
					opts = {
						border = {
							style = "rounded",
						},
						position = { row = 2, col = 2 },
					},
				},
				message = { enabled = true, view = "mini" },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				},
			},
			notify = {
				enabled = false,
			},
			routes = {
				{
					filter = { event = "msg_show", kind = "confirm" },
					view = "confirm",
				},
				{
					filter = { event = "msg_show", min_height = 5 },
					view = "split",
				},
				{
					filter = { event = "msg_show", kind = "", find = "written" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", kind = "search_count" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "%d+ lines? " },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "%d+ more lines?" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "%d+ fewer lines?" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "%d+ substitution" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "Already at" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "search hit" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", find = "Pattern not found" },
					opts = { skip = true },
				},
				{
					filter = { event = "msg_show", max_length = 1 },
					opts = { skip = true },
				},
			},
			views = {
				split = {
					enter = true,
					size = "40%",
					close = {
						keys = { "q", "<Esc>" },
					},
				},
			},
			commands = {
				showcmd = { view = false },
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		})

		vim.keymap.set("n", "<leader>nm", "<cmd>Noice<cr>", { desc = "Message History" })
		vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { desc = "Dismiss All" })
		vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<cr>", { desc = "Last Message" })
		vim.keymap.set("n", "<leader>ne", "<cmd>Noice errors<cr>", { desc = "Error Messages" })
	end,
}
