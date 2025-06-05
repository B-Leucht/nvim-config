local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
	wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline()),
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = wilder.popupmenu_renderer({
			highlighter = wilder.basic_highlighter(),
			left = { " ", wilder.popupmenu_devicons() },
			right = { " ", wilder.popupmenu_scrollbar() },
			pumblend = 20,
		}),
		["/"] = wilder.wildmenu_renderer({
			highlighter = wilder.basic_highlighter(),
			separator = " · ",
			left = { " ", wilder.wildmenu_spinner(), " " },
			right = { " ", wilder.wildmenu_index() },
		}),
	})
)
