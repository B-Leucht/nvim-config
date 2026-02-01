return {
	"igorlfs/nvim-dap-view",
	---@module 'dap-view'
	---@type dapview.Config
	opts = {
		winbar = {
			controls = {
				enabled = true,
			},
		},
	},
	keys = { {
		"<leader>du",
		"<cmd>DapViewToggle<cr>",
		desc = "Toggle DAP-View",
	} },
}
