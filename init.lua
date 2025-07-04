-- Bootstrap lazy.nvim plugin manager
require("core.bootstrap").setup()

-- Handle VS Code Neovim integration
if require("core.vscode").setup() then
	return -- Early exit for VS Code
end

-- Load core configuration
require("core.options")
require("core.keymaps")

-- Load plugin setup
require("plugins.init")
