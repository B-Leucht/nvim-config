-- Main plugin configuration entry point
-- Imports all plugin modules and sets up lazy.nvim

local function merge_plugins(...)
	local result = {}
	for _, plugin_list in ipairs({ ... }) do
		vim.list_extend(result, plugin_list)
	end
	return result
end

-- Import all plugin modules
local plugins = merge_plugins(
	require("plugins.core"),
	require("plugins.ui"),
	require("plugins.navigation"),
	require("plugins.lsp"),
	require("plugins.editor"),
	require("plugins.tools"),
	require("plugins.git"),
	require("plugins.lang")
)

-- Setup lazy.nvim with all plugins
require("lazy").setup(plugins)