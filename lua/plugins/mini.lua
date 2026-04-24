local gh = require("utils.gh")

return {
	specs = { gh("echasnovski/mini.nvim") },
	setup = function()
		require("mini.surround").setup({
			mappings = {
				add = "gza",
				delete = "gzd",
				find = "gzf",
				find_left = "gzF",
				highlight = "gzh",
				replace = "gzr",
				update_n_lines = "gzn",
			},
		})
		require("mini.icons").setup()
		require("mini.diff").setup({
			view = {
				style = "sign",
				signs = {
					add = "│",
					change = "│",
					delete = "_",
				},
			},
		})
		vim.keymap.set("n", "<leader>gD", MiniDiff.toggle_overlay, { desc = "Toggle diff overlay" })

		require("mini.git").setup()
		vim.keymap.set("v", "<leader>gB", MiniGit.show_at_cursor, { desc = "Git blame selection" })

		require("mini.ai").setup({
			n_lines = 500,
		})

		require("mini.move").setup()

		require("mini.splitjoin").setup()

		require("mini.align").setup()

		local map = require("mini.map")
		map.setup({
			integrations = {
				map.gen_integration.diagnostic(),
				map.gen_integration.builtin_search(),
				map.gen_integration.diff(),
			},
			window = {
				width = 1,
				show_integration_count = false,
				winblend = 0,
			},
		})

		require("mini.sessions").setup({
			autoread = false,
			autowrite = true,
			directory = vim.fn.stdpath("state") .. "/sessions/",
		})

		local show_dotfiles = true
		local filter_show = function()
			return true
		end
		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end
		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			MiniFiles.refresh({ content = { filter = new_filter } })
		end

		require("mini.files").setup({
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "<CR>",
				go_out = "h",
				go_out_plus = "H",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			options = {
				use_as_default_explorer = true,
				permanent_delete = false,
			},
			windows = {
				preview = true,
				width_preview = 40,
				border = "rounded",
			},
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = args.data.buf_id, desc = "Toggle dotfiles" })
				vim.keymap.set("n", "gx", function()
					local entry = MiniFiles.get_fs_entry()
					if entry and entry.path then
						vim.ui.open(entry.path)
					end
				end, { buffer = args.data.buf_id, desc = "Open with system handler" })
			end,
		})

		vim.keymap.set("n", "-", function()
			local bufname = vim.api.nvim_buf_get_name(0)
			if bufname:match("^minifiles://") then
				MiniFiles.go_out()
			elseif bufname ~= "" and vim.uv.fs_stat(bufname) then
				MiniFiles.open(bufname)
			else
				MiniFiles.open()
			end
		end, { desc = "Explorer (current file)" })
		vim.keymap.set("n", "_", function()
			MiniFiles.open()
		end, { desc = "Explorer (cwd)" })

		MiniIcons.mock_nvim_web_devicons()
	end,
}
