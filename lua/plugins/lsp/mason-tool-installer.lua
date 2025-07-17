return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "williamboman/mason.nvim" },
	lazy = false,
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Python tools
				"black",
				"ruff",
				"mypy",
				-- Lua tools (for Neovim config)
				"stylua",
				"luacheck",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
