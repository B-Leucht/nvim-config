return {
	markdown = {
		headings = presets.headings.simple,
		horizontal_rules = presets.horizontal_rules.dashed,
		tables = presets.tables.single,
		icon_provider = "mini",
	},
	preview = {
		enable = false,
		enable_hybrid_mode = false,
		hybrid_modes = { "i" },
		modes = { "n" }, -- Other modes still get preview, just not hybrid
	},
}
