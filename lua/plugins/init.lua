local function merge_plugins(...)
	local result = {}
	for _, plugin_list in ipairs({ ... }) do
		vim.list_extend(result, plugin_list)
	end
	return result
end

local plugins = merge_plugins(
	require("plugins.core"),
	require("plugins.ui"),
	require("plugins.lsp"),
	require("plugins.syntax"),
	require("plugins.ai"),
	require("plugins.debug"),
	require("plugins.tools"),
	require("plugins.lang")
)

require("lazy").setup(plugins, {
	ui = {
		border = "rounded",
	},
})
