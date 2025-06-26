-- VS Code Neovim integration handler
local M = {}

function M.setup()
	if vim.g.vscode then
		-- Load minimal VS Code specific config
		require("plugins.vscode")
		require("config.vscode.vscode-options")
		require("config.vscode.vscode-actions")
		return true -- Indicates early exit needed
	end
	return false -- Continue with normal config
end

return M