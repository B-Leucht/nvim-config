-- File management
return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	lazy = false,
	keys = {
		{
			"-",
			function()
				local ft = vim.bo.filetype
				if ft == "snacks_terminal" or ft == "terminal" or ft == "trouble" then
					return
				end
				require("oil").open_float(nil, { preview = { update_on_cursor_moved = true } })
			end,
			desc = "Open parent directory",
		},
		{
			"<leader>fo",
			function()
				require("oil").open_float(nil, { preview = { update_on_cursor_moved = true } })
			end,
			desc = "Open oil (parent directory)",
		},
		{
			"<leader>fO",
			function()
				require("oil").open_float(vim.fn.getcwd(), { preview = { update_on_cursor_moved = true } })
				end,
			desc = "Open oil (cwd)",
		},
	},
	opts = {
		-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
		default_file_explorer = true,
		-- Id is automatically added at the beginning, and name at the end
		-- See :help oil-columns
		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime",
		},
		-- Buffer-local options to use for oil buffers
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		-- Window-local options to use for oil buffers
		win_options = {
			wrap = false,
			signcolumn = "yes:2",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
		delete_to_trash = true,
		-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
		skip_confirm_for_simple_edits = false,
		-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
		-- (:help oil.prompt_save_on_select_new_entry)
		prompt_save_on_select_new_entry = true,
		-- Oil will automatically delete hidden buffers after this delay
		-- You can set the delay to false to disable cleanup entirely
		-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
		cleanup_delay_ms = 2000,
		lsp_file_methods = {
			-- Time to wait for LSP file operations to complete before skipping
			timeout_ms = 1000,
			-- Set to true to autosave buffers that are updated with LSP willRenameFiles
			-- Set to "unmodified" to only autosave unmodified buffers
			autosave_changes = false,
		},
		-- Constrain the cursor to the editable parts of the oil buffer
		-- Set to `false` to disable, or "name" to keep it on the file names
		constrain_cursor = "editable",
		-- Set to true to watch the filesystem for changes and reload oil
		watch_for_changes = false,
		-- Set to false to disable all of the above keymaps
		use_default_keymaps = true,
		keymaps = {
			["q"] = "actions.close",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = false,
			-- This function defines what is considered a "hidden" file
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".")
			end,
			-- This function defines what will never be shown, even when `show_hidden` is set
			is_always_hidden = function(name, bufnr)
				return false
			end,
			-- Sort file names in a more intuitive order for humans. Is less performant,
			-- so you may want to set to false if you work with large directories.
			natural_order = true,
			-- Sort file and directory names case insensitive
			case_insensitive = false,
			sort = {
				-- sort order can be "asc" or "desc"
				-- see :help oil-columns to see which columns are sortable
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},
		-- Extra arguments to pass to SCP when moving/copying files over SSH
		extra_scp_args = {},
		-- EXPERIMENTAL support for performing file operations with git
		git = {
			-- Return true to automatically git add/mv/rm files
			add = function(path)
				return false
			end,
			mv = function(src_path, dest_path)
				return false
			end,
			rm = function(path)
				return false
			end,
		},
		-- Configuration for the floating window in oil.open_float
		float = {
			-- Padding around the floating window
			padding = require("core.constants").FLOAT.PADDING,
			max_width = require("core.constants").FLOAT.WIDTH,
			max_height = require("core.constants").FLOAT.HEIGHT,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			-- preview_split: Split direction: "auto", "left", "right", "above", "below".
			preview_split = "auto",
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			override = function(conf)
				return conf
			end,
		},
		-- Configuration for the actions floating preview window
		preview = {
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
			max_width = 0.9,
			-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
			min_width = { 40, 0.4 },
			-- optionally define an integer/float for the exact width of the preview window
			width = nil,
			-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_height and max_height can be a single value or a list of mixed integer/float types.
			-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
			max_height = 0.9,
			min_height = { 5, 0.1 },
			-- optionally define an integer/float for the exact height of the preview window
			height = nil,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			-- Whether the preview window is automatically updated when the cursor is moved
			update_on_cursor_moved = true,
		},
		-- Configuration for the floating progress window
		progress = {
			max_width = 0.9,
			min_width = { 40, 0.4 },
			width = nil,
			max_height = { 10, 0.9 },
			min_height = { 5, 0.1 },
			height = nil,
			border = "rounded",
			minimized_border = "none",
			win_options = {
				winblend = 0,
			},
		},
		-- Configuration for the floating SSH window
		ssh = {
			border = "rounded",
		},
	},
}