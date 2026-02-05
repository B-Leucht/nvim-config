-- Mini.nvim collection
return {
	"echasnovski/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		-- mini.comment removed - using ts-comments.nvim for better treesitter-aware commenting
		require("mini.pairs").setup()
		require("mini.surround").setup()
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

		-- Git commands and blame
		require("mini.git").setup()
		vim.keymap.set("n", "<leader>gB", MiniGit.show_at_cursor, { desc = "Git blame line" })
		vim.keymap.set("v", "<leader>gB", MiniGit.show_at_cursor, { desc = "Git blame selection" })

		-- Enhanced text objects (vaq = around quotes, vab = around brackets, etc.)
		require("mini.ai").setup({
			n_lines = 500,
		})

		-- Move lines/selections with Alt+hjkl
		require("mini.move").setup()

		-- Toggle single/multiline (gS to split, gJ to join)
		require("mini.splitjoin").setup()

		-- Bracketed navigation ([b/]b for buffers, [d/]d for diagnostics, etc.)
		require("mini.bracketed").setup()

		-- Session management
		require("mini.sessions").setup({
			autoread = false,
			autowrite = true,
			directory = vim.fn.stdpath("state") .. "/sessions/",
		})

		-- File explorer
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
			},
			windows = {
				preview = true,
				width_preview = 40,
			},
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
			-- Don't try to open minifiles:// paths
			if bufname:match("^minifiles://") then
				MiniFiles.go_out()
			else
				MiniFiles.open(bufname)
			end
		end, { desc = "Explorer (current file)" })
		vim.keymap.set("n", "_", function()
			MiniFiles.open()
		end, { desc = "Explorer (cwd)" })

		MiniIcons.mock_nvim_web_devicons()
	end,
}
