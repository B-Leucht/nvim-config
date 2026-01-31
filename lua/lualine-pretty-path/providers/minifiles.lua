---@class PrettyPath.MiniFilesProvider: PrettyPath.Provider
---@field super PrettyPath.Provider
local M = require("lualine-pretty-path.providers.base"):extend()

function M.can_handle()
	return vim.bo.filetype == "minifiles"
end

function M:format_path(_)
	local ok, files = pcall(require, "mini.files")
	if ok then
		local entry = files.get_fs_entry()
		if entry then
			return entry.path
		end
	end
	return vim.fn.getcwd()
end

function M:render_dir()
	local dir = self.super.render_dir(self) or ""
	dir = dir:sub(1, #dir - #self.path_sep)

	local hl = self.opts.highlights.filename
	if self:is_modified() then
		hl = self.opts.highlights.modified
	end

	return self.hl(dir, hl)
end

function M:render()
	return table.concat({
		self:render_dir() or "",
		self:render_symbols() or "",
	}, "")
end

return M
