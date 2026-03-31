local gh = function(x) return "https://github.com/" .. x end

local cached_palette = nil
local function get_palette()
	if not cached_palette then
		cached_palette = require("catppuccin.palettes").get_palette()
	end
	return cached_palette
end

local scope_types = {
	function_declaration = true,
	function_definition = true,
	method_declaration = true,
	method_definition = true,
	class_declaration = true,
	class_definition = true,
	struct_item = true,
	impl_item = true,
	enum_item = true,
}

local function get_treesitter_context(buf, win)
	local ok, parser = pcall(vim.treesitter.get_parser, buf)
	if not ok or not parser then
		return nil
	end

	local cursor = vim.api.nvim_win_get_cursor(win)
	local row = cursor[1] - 1

	local node = vim.treesitter.get_node({ bufnr = buf, pos = { row, 0 } })
	while node do
		if scope_types[node:type()] then
			local name_node = node:field("name")[1]
			if name_node then
				return vim.treesitter.get_node_text(name_node, buf)
			end
		end
		node = node:parent()
	end
	return nil
end

return {
	specs = { gh("b0o/incline.nvim") },
	setup = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				cached_palette = nil
			end,
		})
		require("incline").setup({
			hide = {
				cursorline = true,
				focused_win = false,
				only_win = false,
			},
			window = {
				padding = 0,
				margin = { horizontal = 0, vertical = 0 },
			},
			highlight = {
				groups = {
					InclineNormal = { guibg = "none" },
					InclineNormalNC = { guibg = "none" },
				},
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end

				local ft_icon, ft_hl = MiniIcons.get("file", filename)
				local ft_color = vim.api.nvim_get_hl(0, { name = ft_hl, link = false }).fg
				local modified = vim.bo[props.buf].modified
				local palette = get_palette()
				local bg = props.focused and palette.surface0 or palette.mantle
				local fg = props.focused and palette.blue or palette.surface1

				local result = {
					{ "\u{e0b6}", guifg = bg },
					{ "", guibg = bg },
					{ ft_icon .. " ", guifg = ft_color and string.format("#%06x", ft_color) or nil, guibg = bg },
					{ filename, gui = "bold", guifg = modified and palette.peach or fg, guibg = bg },
				}

				if props.focused then
					local context = get_treesitter_context(props.buf, props.win)
					if context then
						table.insert(result, { "  " .. context, guifg = palette.overlay0, guibg = bg })
					end
				end

				table.insert(result, { "", guibg = bg })
				table.insert(result, { "\u{e0b4}", guifg = bg })

				return result
			end,
		})
	end,
}
