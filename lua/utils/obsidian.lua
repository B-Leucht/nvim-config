local M = {}

---@param vault string?
---@return table[]
function M.fetch_tasks(vault)
	vault = vault or os.getenv("OBSIDIAN_VAULT")
	local tasks = {}
	local result = vim.system({ "rg", "-n", "-e", "- \\[ \\].*TODO", "-g", "!05_Meta/**", vault }, { text = true })
		:wait()
	if result.code == 0 and result.stdout then
		for line in result.stdout:gmatch("[^\n]+") do
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
	end
	table.sort(tasks, function(a, b)
		return a.date < b.date
	end)
	return tasks
end

return M
