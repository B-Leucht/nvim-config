---@class PrettyPath.SnacksTerminalProvider: PrettyPath.Provider
---@field super PrettyPath.Provider
local M = require("lualine-pretty-path.providers.base"):extend()

function M.can_handle()
	return vim.bo.filetype == "snacks_terminal" or vim.bo.filetype == "terminal"
end

function M:format_path(_)
	-- Return terminal buffer name or current working directory
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname ~= "" then
		return bufname
	end
	return vim.fn.getcwd()
end

function M:render_filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	local display = "Terminal"

	-- Try to extract command or terminal ID from buffer name
	if bufname and bufname ~= "" then
		-- Check if it's a named terminal (e.g., "term://...//1234:ipython")
		local cmd = bufname:match(":([^:]+)$")
		if cmd and cmd ~= "" then
			display = display .. ": " .. cmd
		else
			-- Just show terminal number if available
			local num = bufname:match("//(%d+):")
			if num then
				display = display .. " " .. num
			end
		end
	end

	local hl = self.opts.highlights.filename
	if self:is_modified() then
		hl = self.opts.highlights.modified
	end

	return self.hl(display, hl)
end

function M:render()
	return table.concat({
		self:render_icon() or "",
		self:render_filename() or "",
		self:render_symbols() or "",
	}, "")
end

return M
