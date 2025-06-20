local presets = require("markview.presets")

require("markview").setup({
	markdown = {
		headings = presets.headings.simple,
		horizontal_rules = presets.horizontal_rules.dashed,
		tables = presets.tables.single,
		icon_provider = "devicons",
	},
	avante = {
		headings = presets.headings.advanced,
		horizontal_rules = presets.horizontal_rules.solid,
		tables = presets.tables.enhanced,
		icon_provider = "custom-icons",
	},
	preview = {
		enable = false,
		enable_hybrid_mode = false,
		hybrid_modes = { "i" },
		modes = { "n" }, -- Other modes still get preview, just not hybrid
	},
})


