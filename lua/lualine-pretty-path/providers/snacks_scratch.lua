---@class PrettyPath.SnacksScratchProvider: PrettyPath.Provider
---@field super PrettyPath.Provider
local M = require("lualine-pretty-path.providers.base"):extend()

function M.can_handle()
	local bufname = vim.api.nvim_buf_get_name(0)
	-- Scratch buffers are stored in stdpath("data")/scratch/
	return bufname:match("scratch/.*%.%w+$") ~= nil
end

function M:format_path(_)
	local bufname = vim.api.nvim_buf_get_name(0)
	-- Extract just the filename from the scratch path
	return vim.fn.fnamemodify(bufname, ":t")
end

function M:render_filename()
	local bufname = vim.api.nvim_buf_get_name(0)
	local filename = vim.fn.fnamemodify(bufname, ":t:r") -- name without extension
	local ft = vim.bo.filetype

	local hl = self.opts.highlights.filename
	if self:is_modified() then
		hl = self.opts.highlights.modified
	end

	-- Show as "Scratch: name (filetype)"
	local display = "Scratch"
	if filename and filename ~= "" and filename ~= "scratch" then
		display = display .. ": " .. filename
	end
	if ft and ft ~= "" then
		display = display .. " (" .. ft .. ")"
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
