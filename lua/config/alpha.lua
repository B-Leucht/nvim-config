local dashboard = require("alpha.themes.dashboard")

local mocha = require("catppuccin.palettes").get_palette("mocha")

vim.api.nvim_set_hl(0, "AlphaHeaderGreen", { fg = mocha.green, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "AlphaHeaderRed", { fg = mocha.red, bg = "NONE", bold = true })

dashboard.section.header.val = {
	[[                                                     ]],
	[[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
	[[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
	[[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
	[[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
	[[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
	[[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
	[[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
	[[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
	[[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
	[[                                 ░                   ]],
	[[                                                     ]],
}
dashboard.section.header.opts.hl = "AlphaHeaderGreen"
-- Helper function to open files from alpha with flag set
local function open_from_alpha(cmd)
	-- Set the flag, then run the cmd
	return "<cmd>lua _G.opened_from_alpha = true<CR><cmd>" .. cmd .. "<CR>"
end

dashboard.section.buttons.val = {
	dashboard.button("f", "󰍉  Find file", open_from_alpha("FzfLua files")),
	dashboard.button("r", "  Recent files", open_from_alpha("FzfLua oldfiles")),
	dashboard.button("g", "  Live grep", open_from_alpha("FzfLua live_grep")),
	dashboard.button("b", "  Bookmarks", open_from_alpha("FzfLua marks")),
	dashboard.button("c", "  Configuration", open_from_alpha("edit ~/.config/nvim/init.lua")),
	dashboard.button("q", "󰗼  Quit NVIM", ":qa<CR>"),
}

dashboard.config.opts.noautocmd = true

require("alpha").setup(dashboard.config)

-- Auto change working directory to the opened file's directory
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		if _G.opened_from_alpha and vim.fn.expand("%") ~= "" then
			vim.cmd("cd %:p:h")
			_G.opened_from_alpha = nil -- reset flag
		end
	end,
})
