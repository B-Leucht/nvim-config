local function collect_modules(...)
	local modules = {}
	for _, group in ipairs({ ... }) do
		for _, mod in ipairs(group) do
			table.insert(modules, mod)
		end
	end
	return modules
end

local modules = collect_modules(
	require("plugins.core"),
	require("plugins.ui"),
	require("plugins.lsp"),
	require("plugins.syntax"),
	require("plugins.ai"),
	require("plugins.debug"),
	require("plugins.tools"),
	require("plugins.lang")
)

-- Pre-load init (vim.g settings that must be set before plugins load)
for _, mod in ipairs(modules) do
	if mod.init then
		mod.init()
	end
end

-- Build hooks for post-install/update actions
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end
		if name == "nvim-treesitter" then
			vim.schedule(function() vim.cmd("TSUpdate") end)
		elseif name == "mason.nvim" then
			vim.schedule(function() vim.cmd("MasonUpdate") end)
		elseif name == "molten-nvim" then
			vim.schedule(function()
				if vim.fn.exists(":UpdateRemotePlugins") == 2 then
					vim.cmd("UpdateRemotePlugins")
				end
			end)
		end
	end,
})

-- Collect all specs and install/load plugins
local specs = {}
for _, mod in ipairs(modules) do
	if mod.specs then
		vim.list_extend(specs, mod.specs)
	end
end

vim.pack.add(specs)

-- Post-load setup
for _, mod in ipairs(modules) do
	if mod.setup then
		mod.setup()
	end
end
