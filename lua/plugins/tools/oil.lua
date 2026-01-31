-- File management
return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function(_, opts)
		require("oil").setup(opts)
		-- Integrate with Snacks rename for LSP file rename support
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions[1].type == "move" then
					Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
				end
			end,
		})
	end,
	keys = {
		{
			"-",
			function()
				local ft = vim.bo.filetype
				if ft == "snacks_terminal" or ft == "terminal" then
					return
				end
				require("oil").open()
				vim.defer_fn(function()
					require("oil").open_preview()
				end, 50)
			end,
			desc = "Open parent directory",
		},
	},
	opts = {
		delete_to_trash = true,
		keymaps = {
			["q"] = "actions.close",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
		},
		git = {
			add = function(path)
				return true
			end,
			mv = function(src_path, dest_path)
				return true
			end,
			rm = function(path)
				return true
			end,
		},
		float = {
			padding = require("core.constants").FLOAT.PADDING,
			max_width = require("core.constants").FLOAT.WIDTH,
			max_height = require("core.constants").FLOAT.HEIGHT,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
	},
}
