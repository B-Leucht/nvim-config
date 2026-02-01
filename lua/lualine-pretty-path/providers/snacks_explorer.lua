---@class PrettyPath.SnacksExplorerProvider: PrettyPath.Provider
---@field super PrettyPath.Provider
local M = require("lualine-pretty-path.providers.base"):extend()

function M.can_handle()
	return vim.bo.filetype == "snacks_explorer"
end

function M:format_path(_)
	-- Try to get current path from Snacks explorer
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.explorer then
		-- Get the explorer state if available
		local state = snacks.explorer.state
		if state and state.cwd then
			return state.cwd
		end
	end
	-- Fallback to current working directory
	return vim.fn.getcwd()
end

function M:render_dir()
	local dir = self.super.render_dir(self) or ""
	-- Remove trailing separator
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
