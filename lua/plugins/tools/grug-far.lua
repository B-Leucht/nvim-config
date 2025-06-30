-- Search and replace
return {
	"MagicDuck/grug-far.nvim",
	keys = {
		{
			"<leader>sr",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "v" },
			desc = "Search and Replace",
		},
		{
			"<leader>sR",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						paths = vim.fn.expand("%"),
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "v" },
			desc = "Search and Replace (current file)",
		},
		{
			"<leader>sw",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			desc = "Search and Replace Word",
		},
		{
			"<leader>sW",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						paths = vim.fn.expand("%"),
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			desc = "Search and Replace Word (current file)",
		},
		{
			"<leader>sv",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						search = vim.fn.getreg("0"),
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = "v",
			desc = "Search and Replace Selection",
		},
	},
	opts = {
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
	},
}

