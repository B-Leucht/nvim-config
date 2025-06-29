local constants = require("core.constants")

return {
	windowCreationCommand = "split",
	keymaps = {
		replace = { n = "<localleader>r" },
		qflist = { n = "<localleader>q" },
		syncLocations = { n = "<localleader>s" },
		syncLine = { n = "<localleader>l" },
		close = { n = "<localleader>c" },
		historyOpen = { n = "<localleader>t" },
		historyAdd = { n = "<localleader>a" },
		refresh = { n = "<localleader>f" },
		openLocation = { n = "<localleader>o" },
		gotoLocation = { n = "<enter>" },
		pickHistoryEntry = { n = "<enter>" },
		abort = { n = "<localleader>b" },
		help = { n = "g?" },
		toggleShowCommand = { n = "<localleader>p" },
		swapEngine = { n = "<localleader>e" },
	},
	engines = {
		ripgrep = {
			path = "rg",
			extraArgs = "",
			placeholders = {
				enabled = true,
				search = "ex: foo    foo([A-z0-9]*)    fun\\(",
				replacement = "ex: bar    ${1}_foo    ren(",
				filesFilter = "ex: *.lua    *.{css,js}    **/docs/*.md",
				flags = "ex: --help --ignore-case (-i) --replace= (-r) --multiline (-U)",
				paths = "ex: /foo/bar    ../    ./hello\\ world/",
			},
		},
		astgrep = {
			path = "sg",
			extraArgs = "",
			placeholders = {
				enabled = true,
				search = "ex: $A && $A()    useState($$$ARGS)    $PROP: $VAL",
				replacement = "ex: $A && $A()    useState($$$ARGS)    $PROP: $VAL",
				filesFilter = "ex: *.lua    *.{css,js}    **/docs/*.md",
				flags = "ex: --help (-h)",
				paths = "ex: /foo/bar    ../    ./hello\\ world/",
			},
		},
	},
	-- maximum number of parallel replacements tasks
	maxWorkers = 4,
	-- set to true if you want to see the command being run in the message area
	showCommand = false,
	icons = {
		enabled = true,
		searchInput = " ",
		replaceInput = " ",
		filesFilterInput = " ",
		flagsInput = " ",
		resultsStatusReady = "󱩾 ",
		resultsStatusError = " ",
		resultsStatusSuccess = "󰗡 ",
		resultsChangeIndicator = "┃",
		historyTitle = "󰋚 ",
		helpTitle = "󰘥 ",
	},
	-- highlight groups for the current search match, to override defaults, set 'link' to nil
	-- to disable these highlights, set all to false
	resultLocation = {
		hl = "Directory",
		link = nil,
	},
	-- highlight group for the search and replace input and flags text, to override defaults, set 'link' to nil
	-- to disable these highlights, set all to false
	searchInputLabel = {
		hl = "Title",
		link = nil,
	},
	replaceInputLabel = {
		hl = "Title",
		link = nil,
	},
	filesFilterInputLabel = {
		hl = "Title",
		link = nil,
	},
	flagsInputLabel = {
		hl = "Title",
		link = nil,
	},
	-- set to true to make grug-far buffer always report no changes
	-- to make 'q' just close the window instead of prompting for confirmation
	reportChanges = true,
}