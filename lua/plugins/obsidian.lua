local gh = require("utils.gh")

return {
	specs = {
		gh("obsidian-nvim/obsidian.nvim"),
		gh("nvim-lua/plenary.nvim"),
	},
	setup = function()
		require("obsidian").setup({
			legacy_commands = false,
			workspaces = {
				{
					name = "personal",
					path = os.getenv("OBSIDIAN_VAULT"),
				},
			},
			daily_notes = {
				folder = "01_Daily",
				date_format = "%Y-%m-%d",
				template = "Daily.md",
			},
			templates = {
				folder = "05_Meta/Templates",
			},
			attachments = {
				folder = "05_Meta/Attachments",
			},
			picker = {
				name = "snacks.picker",
			},
		})

		vim.keymap.set("n", "<leader>od", function() vim.cmd("Obsidian today") end, { desc = "Daily Note" })
		vim.keymap.set("n", "<leader>oy", function() vim.cmd("Obsidian yesterday") end, { desc = "Yesterday" })
		vim.keymap.set("n", "<leader>oT", function() vim.cmd("Obsidian tomorrow") end, { desc = "Tomorrow" })
		vim.keymap.set("n", "<leader>on", function() vim.cmd("Obsidian new") end, { desc = "New Note" })
		vim.keymap.set("n", "<leader>oN", function() vim.cmd("Obsidian new_from_template") end, { desc = "New from Template" })
		vim.keymap.set("n", "<leader>os", function() vim.cmd("Obsidian search") end, { desc = "Search Notes" })
		vim.keymap.set("n", "<leader>oq", function() vim.cmd("Obsidian quick_switch") end, { desc = "Quick Switch" })
		vim.keymap.set("n", "<leader>ob", function() vim.cmd("Obsidian backlinks") end, { desc = "Backlinks" })
		vim.keymap.set("n", "<leader>ot", function() vim.cmd("Obsidian tags") end, { desc = "Tags" })
		vim.keymap.set("n", "<leader>ol", function() vim.cmd("Obsidian links") end, { desc = "Links" })
		vim.keymap.set("n", "<leader>oc", function() vim.cmd("Obsidian toc") end, { desc = "Table of Contents" })
		vim.keymap.set("n", "<leader>or", function() vim.cmd("Obsidian rename") end, { desc = "Rename Note" })
		vim.keymap.set("n", "<leader>oi", function() vim.cmd("Obsidian paste_img") end, { desc = "Paste Image" })
		vim.keymap.set("n", "<leader>oo", function() vim.cmd("Obsidian open") end, { desc = "Open in Obsidian App" })
		vim.keymap.set("n", "<leader>om", function()
			local vault = os.getenv("OBSIDIAN_VAULT") .. "/"
			local current_file = vim.fn.expand("%:p")
			local current_name = vim.fn.expand("%:t")

			local dirs = { "." }
			local result = vim.system({ "find", vault, "-type", "d", "-not", "-path", "*/.*" }, { text = true }):wait()
			if result.code == 0 and result.stdout then
				for line in result.stdout:gmatch("[^\n]+") do
					local rel = line:gsub(vault, "")
					if rel ~= "" then
						table.insert(dirs, rel)
					end
				end
			end

			Snacks.picker.select(dirs, { prompt = "Move note to" }, function(selected)
				if selected then
					local target_dir = selected == "." and vault or vault .. selected
					local target_path = target_dir .. "/" .. current_name
					if current_file ~= target_path then
						vim.fn.rename(current_file, target_path)
						vim.cmd("edit " .. vim.fn.fnameescape(target_path))
						vim.notify("Moved to " .. selected, vim.log.levels.INFO)
					end
				end
			end)
		end, { desc = "Move Note" })
	end,
}
