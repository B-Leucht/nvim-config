-- Obsidian utility functions
local M = {}

--- Fetch open tasks from the Obsidian vault, sorted by due date
---@param vault string? Optional vault path (defaults to constants.PATHS.OBSIDIAN_VAULT)
---@return table[] tasks Array of {file, lnum, text, date, filename}
function M.fetch_tasks(vault)
	vault = vault or require("core.constants").PATHS.OBSIDIAN_VAULT
	local tasks = {}
	local handle = io.popen(
		"rg -n -e '- \\[ \\].*TODO' -g '!05_Meta/**' " .. vim.fn.shellescape(vault) .. " 2>/dev/null"
	)
	if handle then
		for line in handle:lines() do
			local file, lnum, text = line:match("^(.+):(%d+):(.*)$")
			if file and text then
				local date = text:match("%[due::%s*(%d%d%d%d%-%d%d%-%d%d)%]") or "9999-99-99"
				local filename = vim.fn.fnamemodify(file, ":t:r")
				table.insert(tasks, {
					file = file,
					lnum = tonumber(lnum),
					text = text,
					date = date,
					filename = filename,
				})
			end
		end
		handle:close()
	end
	table.sort(tasks, function(a, b)
		return a.date < b.date
	end)
	return tasks
end

return M
