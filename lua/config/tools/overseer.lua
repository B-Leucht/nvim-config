local constants = require("core.constants")

return {
	task_list = {
		direction = "bottom",
		min_height = constants.TERMINAL.SIZE,
		max_height = constants.TERMINAL.SIZE,
		default_detail = 1,
		bindings = {
			["<C-l>"] = false,
			["<C-h>"] = false,
			["<C-j>"] = false,
			["<C-k>"] = false,
		},
	},
	task_runner = {
		on_output_parse = true,
	},
	component_aliases = {
		default = {
			{ "display_duration", detail_level = 2 },
			"on_output_summarize",
			"on_exit_set_status",
			{ "on_complete_notify", system = "unfocused" },
		},
	},
}