local constants = require("core.constants")

return {
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
		{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		{
			icon = " ",
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
		{ icon = "", key = "c", desc = "Configuration", action = ":e " .. constants.PATHS.INIT_LUA },
		{ icon = "󰗼", key = "q", desc = "Quit", action = ":qa" },
	},
}