-- Essential editor plugins for Python development
return {
	require("plugins.editor.treesitter"),
	require("plugins.editor.todo-comments"),
	require("plugins.editor.cmp"),
	require("plugins.editor.luasnip"),
	require("plugins.editor.conform"),
	require("plugins.editor.nvim-lint"),
}
