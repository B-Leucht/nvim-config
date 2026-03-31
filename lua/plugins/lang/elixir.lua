local gh = function(x) return "https://github.com/" .. x end

return {
	specs = {
		gh("elixir-tools/elixir-tools.nvim"),
		gh("nvim-lua/plenary.nvim"),
	},
	setup = function()
		local elixir = require("elixir")

		elixir.setup({
			nextls = {
				enable = true,
				init_options = {
					experimental = {
						completions = { enable = true },
					},
				},
			},
			elixirls = { enable = false },
			projectionist = { enable = false },
		})
	end,
}
