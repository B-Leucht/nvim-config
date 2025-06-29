return {
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
}