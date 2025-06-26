-- LSP keymaps for lspconfig and lspsaga
local constants = require("core.constants")

return {
	-- LSPSaga keymaps that can be lazy loaded
	{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover documentation" },
	{ "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "LSP finder" },
	{ "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code actions" },
	{ "gr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
	{ "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" },
	{ "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
	{ "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
	{ "<leader>gt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Peek type definition" },
	{ "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
	{ "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show cursor diagnostics" },
	{ "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Show buffer diagnostics" },
	{ "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Outline" },
}