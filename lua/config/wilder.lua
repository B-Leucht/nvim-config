local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
	wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline()),
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
			highlighter = wilder.basic_highlighter(),
			highlights = {
				accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#b4befe" } }),
			},
			left = {
				" ",
				wilder.popupmenu_devicons(),
				wilder.popupmenu_buffer_flags({
					flags = " a + ",
					icons = {
						["+"] = "", -- nf-md-function or nf-fa-plus
						a = "", -- nf-mdi-file_document
						h = "", -- nf-md-history
					},
				}),
			},
			-- 'single', 'double', 'rounded' or 'solid'
			-- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
			border = "rounded",
			max_height = "75%", -- max height of the palette
			min_height = 0, -- set to the same as 'max_height' for a fixed height window
			prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
			reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
		})),
		["/"] = wilder.wildmenu_renderer({
			highlighter = wilder.basic_highlighter(),
			separator = " · ",
			left = { " ", wilder.wildmenu_spinner(), " " },
			right = { " ", wilder.wildmenu_index() },
		}),
	})
)
