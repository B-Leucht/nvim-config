-- Obsidian.nvim - Community fork with snacks.picker support
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "ibhagwan/fzf-lua",
	},
	keys = {
		{
			"<leader>od",
			function()
				vim.cmd("Obsidian today")
			end,
			desc = "Daily Note",
		},
		{
			"<leader>oy",
			function()
				vim.cmd("Obsidian yesterday")
			end,
			desc = "Yesterday",
		},
		{
			"<leader>oT",
			function()
				vim.cmd("Obsidian tomorrow")
			end,
			desc = "Tomorrow",
		},
		{
			"<leader>on",
			function()
				vim.cmd("Obsidian new")
			end,
			desc = "New Note",
		},
		{
			"<leader>oN",
			function()
				vim.cmd("Obsidian new_from_template")
			end,
			desc = "New from Template",
		},
		{
			"<leader>os",
			function()
				vim.cmd("Obsidian search")
			end,
			desc = "Search Notes",
		},
		{
			"<leader>oq",
			function()
				vim.cmd("Obsidian quick_switch")
			end,
			desc = "Quick Switch",
		},
		{
			"<leader>ob",
			function()
				vim.cmd("Obsidian backlinks")
			end,
			desc = "Backlinks",
		},
		{
			"<leader>ot",
			function()
				vim.cmd("Obsidian tags")
			end,
			desc = "Tags",
		},
		{
			"<leader>ol",
			function()
				vim.cmd("Obsidian links")
			end,
			desc = "Links",
		},
		{
			"<leader>oc",
			function()
				vim.cmd("Obsidian toc")
			end,
			desc = "Table of Contents",
		},
		{
			"<leader>or",
			function()
				vim.cmd("Obsidian rename")
			end,
			desc = "Rename Note",
		},
		{
			"<leader>oi",
			function()
				vim.cmd("Obsidian paste_img")
			end,
			desc = "Paste Image",
		},
		{
			"<leader>oo",
			function()
				vim.cmd("Obsidian open")
			end,
			desc = "Open in Obsidian App",
		},
		{
			"<leader>oO",
			function()
				local vault = "/Users/b.leucht/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault"
				local current_file = vim.fn.expand("%:p")
				-- Exclude 05_Meta and current file
				local exclude_globs = { "!05_Meta/**" }
				if current_file:find(vault, 1, true) then
					local rel = current_file:gsub(vault .. "/", "")
					table.insert(exclude_globs, "!" .. rel)
				end
				Snacks.picker.grep({
					cwd = vault,
					search = "- \\[ \\].*TODO",
					glob = exclude_globs,
				})
			end,
			desc = "Open Tasks",
		},
		{
			"<leader>om",
			function()
				local vault = "/Users/b.leucht/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault/"
				local current_file = vim.fn.expand("%:p")
				local current_name = vim.fn.expand("%:t")

				local dirs = { "." }
				local handle = io.popen('find "' .. vault .. '" -type d -not -path "*/\\.*" 2>/dev/null')
				if handle then
					for line in handle:lines() do
						local rel = line:gsub(vault, "")
						if rel ~= "" then
							table.insert(dirs, rel)
						end
					end
					handle:close()
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
			end,
			desc = "Move Note",
		},
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "/Users/b.leucht/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault",
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
			name = "snacks",
		},
	},
}
