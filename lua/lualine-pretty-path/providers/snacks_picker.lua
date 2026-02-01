---@class PrettyPath.SnacksPickerProvider: PrettyPath.Provider
---@field super PrettyPath.Provider
local M = require("lualine-pretty-path.providers.base"):extend()

function M.can_handle()
	local ft = vim.bo.filetype
	return ft == "snacks_picker_input" or ft == "snacks_picker_list" or ft == "snacks_picker_preview"
end

function M:format_path(_)
	-- Try to get picker title from Snacks
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks.picker then
		local state = snacks.picker.state
		if state and state.opts and state.opts.title then
			return state.opts.title
		end
	end
	return "Picker"
end

function M:render_filename()
	local ft = vim.bo.filetype
	local display = ""

	-- Get picker title
	local title = self:format_path(nil)

	-- Different icons based on picker window type
	if ft == "snacks_picker_input" then
		display = " " .. title
	elseif ft == "snacks_picker_list" then
		display = "󰙅 " .. title
	elseif ft == "snacks_picker_preview" then
		display = " " .. title
	else
		display = " " .. title
	end

	local hl = self.opts.highlights.filename
	if self:is_modified() then
		hl = self.opts.highlights.modified
	end

	return self.hl(display, hl)
end

function M:render()
	return table.concat({
		self:render_filename() or "",
		self:render_symbols() or "",
	}, "")
end

return M
