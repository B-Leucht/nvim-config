-- LSP keymaps using native LSP and snacks
local constants = require("core.constants")

return {
	-- Native LSP keymaps
	{ "K", vim.lsp.buf.hover, desc = "Hover documentation" },
	{ "gh", vim.lsp.buf.references, desc = "LSP references" },
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code actions" },
	{ "gr", vim.lsp.buf.rename, desc = "Rename" },
	{ "[e", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
	{ "]e", vim.diagnostic.goto_next, desc = "Next diagnostic" },
	{ "<leader>gd", vim.lsp.buf.definition, desc = "Go to definition" },
	{ "<leader>gt", vim.lsp.buf.type_definition, desc = "Go to type definition" },
	{ "<leader>sl", vim.diagnostic.open_float, desc = "Show line diagnostics" },
	{ "<leader>sb", vim.diagnostic.setloclist, desc = "Show buffer diagnostics" },
	{ "<leader>o", function() Snacks.picker.symbols() end, desc = "Document symbols" },
	{ "<leader>ll", "<cmd>lua switch_ltex_language()<CR>", desc = "Switch LTeX language" },
}