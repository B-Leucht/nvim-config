local snacks = require("snacks")

-- Get catppuccin colors for consistent theming
local mocha = require("catppuccin.palettes").get_palette("mocha")

snacks.setup({
	notifier = {
		enabled = true,
		timeout = 1500,
		style = "minimal",
		top_down = false,
	},
	terminal = {
		win = {
			wo = {
				winbar = "",
			},
		},
	},
	lazygit = {
		enabled = true,
	},
	picker = {
		enabled = true,
		sources = {
			buffers = {
				name = "Buffers",
			},
			files = {
				name = "Files",
			},
			grep = {
				name = "Grep",
			},
		},
		win = {
			input = {
				keys = {
					["<C-j>"] = { "move", "down" },
					["<C-k>"] = { "move", "up" },
				},
			},
		},
	},
	input = {
		enabled = true,
	},
	scope = {
		enabled = true,
	},
	words = {
		enabled = true,
	},
	scroll = {
		enabled = true,
	},
	bufdelete = {
		enabled = true,
	},
	indent = {
		enabled = true,
	},
	zen = {
		enabled = true,
	},
	statuscolumn = {
		enabled = true,
	},
	dim = {
		enabled = true,
	},
	git = {
		enabled = true,
	},
	animate = {
		enabled = true,
	},
	quickfile = {
		enabled = true,
	},
	rename = {
		enabled = true,
	},
	dashboard = {
		enabled = true,
		preset = {
			header = [[
                                                     
  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ 
  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ 
 ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ 
 ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  
 ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ 
 ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ 
 ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ 
    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    
          ░    ░  ░    ░ ░        ░   ░         ░    
                                 ░                   
                                                     ]],
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			{
				pane = 2,
				icon = " ",
				title = "Git Status",
				section = "terminal",
				enabled = function()
					return Snacks.git.get_root() ~= nil
				end,
				cmd = "git status --short --branch --renames",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
			{ section = "startup" },
		},
		keys = {
			{ icon = "󰍉", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
			{ icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
			{ icon = "", key = "g", desc = "Live Grep", action = ":lua Snacks.picker.grep()" },
			{ icon = "", key = "b", desc = "Bookmarks", action = ":lua Snacks.picker.marks()" },
			{ icon = "", key = "c", desc = "Configuration", action = ":e ~/.config/nvim/init.lua" },
			{ icon = "󰗼", key = "q", desc = "Quit", action = ":qa" },
		},
	},
})

-- Load snacks native keymaps, picker, and all features
require("config.tools.snacks-native")
require("config.tools.snacks-picker")
require("config.tools.snacks-features")
require("config.tools.snacks-advanced")

-- Auto change working directory to the opened file's directory (preserving original behavior)
local opened_from_dashboard = false

-- Set flag when opening from dashboard
vim.api.nvim_create_autocmd("User", {
	pattern = "SnacksDashboardOpened",
	callback = function()
		opened_from_dashboard = true
	end,
})

-- Change directory when opening files from dashboard
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		if opened_from_dashboard and vim.fn.expand("%") ~= "" then
			vim.cmd("cd %:p:h")
			opened_from_dashboard = false -- reset flag
		end
	end,
})
