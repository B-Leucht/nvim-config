-- VS Code Neovim integration handler
local M = {}

function M.setup()
	if vim.g.vscode then
		-- Load minimal VS Code specific config
		require("plugins.vscode")
		return true -- Indicates early exit needed
	end
	return false -- Continue with normal config
end

return M

