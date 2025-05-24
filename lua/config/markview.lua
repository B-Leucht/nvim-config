local presets = require("markview.presets")

require("markview").setup({
	markdown = {
		headings = presets.headings.simple,
		horizontal_rules = presets.horizontal_rules.dashed,
		tables = presets.tables.single,
		icon_provider = "devicons",
	},
	preview = {
		enable = false,
		enable_hybrid_mode = false,
		hybrid_modes = { "i" },
		modes = { "n" }, -- Other modes still get preview, just not hybrid
	},
})

local current_tool = nil

function ToggleNablaMarkView()
	if current_tool == "nabla" then
		require("nabla").disable_virt()
		vim.cmd("Markview Enable")
		current_tool = "markview"
		return
	elseif current_tool == "markview" then
		vim.cmd("Markview Disable")
		require("nabla").enable_virt({ autogen = true })
		current_tool = "nabla"
		return
	end

	-- Default: start with Nabla
	require("nabla").enable_virt({ autogen = true })
	current_tool = "nabla"
end

vim.keymap.set("n", "<leader>p", ToggleNablaMarkView, { desc = "Toggle Nabla / MarkView preview" })
