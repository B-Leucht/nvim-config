local SEP_L = "\u{e0b6}" --
local SEP_R = "\u{e0b4}" --

return {
	specs = {},
	setup = function()
		vim.o.laststatus = 3

		local mode_colors = {
			StlMode = "blue",
			StlModeI = "green",
			StlModeV = "mauve",
			StlModeR = "red",
			StlModeC = "peach",
			StlModeT = "teal",
		}

		local function setup_highlights()
			local ok, palette = pcall(function()
				return require("catppuccin.palettes").get_palette()
			end)
			if not ok then
				return
			end
			local c = palette

			-- Mode section
			for hl, col in pairs(mode_colors) do
				vim.api.nvim_set_hl(0, hl, { fg = c.base, bg = c[col], bold = true })
				vim.api.nvim_set_hl(0, hl .. "SepL", { fg = c[col], bg = "NONE" }) -- outer left cap
				vim.api.nvim_set_hl(0, hl .. "SepR", { fg = c[col], bg = c.surface0 }) -- mode→file transition
			end

			-- File section (connected to mode)
			vim.api.nvim_set_hl(0, "StlFile", { fg = c.text, bg = c.surface0 })
			vim.api.nvim_set_hl(0, "StlFileSep", { fg = c.surface0, bg = "NONE" }) -- outer right cap

			-- Middle (no bg)
			vim.api.nvim_set_hl(0, "StlGit", { fg = c.flamingo, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiffAdd", { fg = c.green, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiffChange", { fg = c.yellow, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiffDelete", { fg = c.red, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagError", { fg = c.red, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagWarn", { fg = c.yellow, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagInfo", { fg = c.blue, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagHint", { fg = c.teal, bg = "NONE" })

			-- Progress → Position connected block (position uses mode color)
			vim.api.nvim_set_hl(0, "StlProgressSepL", { fg = c.surface0, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlProgress", { fg = c.text, bg = c.surface0 })
			for hl, col in pairs(mode_colors) do
				vim.api.nvim_set_hl(0, "StlPos" .. hl, { fg = c.base, bg = c[col], bold = true })
				vim.api.nvim_set_hl(0, "StlPos" .. hl .. "SepL", { fg = c[col], bg = c.surface0 })
				vim.api.nvim_set_hl(0, "StlPos" .. hl .. "SepR", { fg = c[col], bg = "NONE" })
			end

			-- Winbar
			vim.api.nvim_set_hl(0, "WbActive", { fg = c.text, bg = c.surface0 })
			vim.api.nvim_set_hl(0, "WbActiveSepL", { fg = c.surface0, bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbActiveSepR", { fg = c.surface0, bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbInactive", { fg = c.overlay0, bg = c.surface0 })
			vim.api.nvim_set_hl(0, "WbInactiveSepL", { fg = c.surface0, bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbInactiveSepR", { fg = c.surface0, bg = "NONE" })

			-- Tabline
			vim.api.nvim_set_hl(0, "StlTabActive", { fg = c.base, bg = c.blue, bold = true })
			vim.api.nvim_set_hl(0, "StlTabActiveSepL", { fg = c.blue, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlTabInactive", { fg = c.text, bg = c.surface0 })
			vim.api.nvim_set_hl(0, "StlTabInactiveSepL", { fg = c.surface0, bg = "NONE" })
			-- transitions between tabs
			vim.api.nvim_set_hl(0, "StlTabA2I", { fg = c.blue, bg = c.surface0 }) -- active → inactive
			vim.api.nvim_set_hl(0, "StlTabI2A", { fg = c.surface0, bg = c.blue }) -- inactive → active
			vim.api.nvim_set_hl(0, "StlTabI2I", { fg = c.surface0, bg = c.surface0 }) -- inactive → inactive (invisible)
			vim.api.nvim_set_hl(0, "StlTabActiveEnd", { fg = c.blue, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlTabInactiveEnd", { fg = c.surface0, bg = "NONE" })
		end

		setup_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_highlights })

		local mode_map = {
			["n"] = { "N", "StlMode" },
			["no"] = { "N·O", "StlMode" },
			["nov"] = { "N·O", "StlMode" },
			["noV"] = { "N·O", "StlMode" },
			["no\22"] = { "N·O", "StlMode" },
			["niI"] = { "N", "StlMode" },
			["niR"] = { "N", "StlMode" },
			["niV"] = { "N", "StlMode" },
			["nt"] = { "N", "StlMode" },
			["i"] = { "I", "StlModeI" },
			["ic"] = { "I", "StlModeI" },
			["ix"] = { "I", "StlModeI" },
			["v"] = { "V", "StlModeV" },
			["vs"] = { "V", "StlModeV" },
			["V"] = { "VL", "StlModeV" },
			["Vs"] = { "VL", "StlModeV" },
			["\22"] = { "VB", "StlModeV" },
			["\22s"] = { "VB", "StlModeV" },
			["s"] = { "S", "StlModeV" },
			["S"] = { "SL", "StlModeV" },
			["\19"] = { "SB", "StlModeV" },
			["R"] = { "R", "StlModeR" },
			["Rc"] = { "R", "StlModeR" },
			["Rx"] = { "R", "StlModeR" },
			["Rv"] = { "VR", "StlModeR" },
			["Rvc"] = { "VR", "StlModeR" },
			["Rvx"] = { "VR", "StlModeR" },
			["c"] = { "C", "StlModeC" },
			["cv"] = { "C", "StlModeC" },
			["ce"] = { "C", "StlModeC" },
			["r"] = { "P", "StlModeC" },
			["rm"] = { "M", "StlModeC" },
			["r?"] = { "?", "StlModeC" },
			["!"] = { "!", "StlModeC" },
			["t"] = { "T", "StlModeT" },
		}

		local stl = {}
		_G._stl = stl

		-- Check if any other listed buffer shares the same tail name
		local function has_duplicate_name(tail)
			local count = 0
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].buflisted and vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") == tail then
					count = count + 1
					if count > 1 then
						return true
					end
				end
			end
			return false
		end

		-- Get file icon with its native highlight, adapted for a given bg group
		local function file_icon(name, ext, bg_hl)
			local ok, devicons = pcall(require, "nvim-web-devicons")
			if not ok then
				return ""
			end
			local icon, icon_hl = devicons.get_icon(name, ext, { default = true })
			if not icon then
				return ""
			end
			if icon_hl then
				local src = vim.api.nvim_get_hl(0, { name = icon_hl })
				local bg_def = vim.api.nvim_get_hl(0, { name = bg_hl })
				local merged = "Stl_" .. icon_hl .. "_" .. bg_hl
				vim.api.nvim_set_hl(0, merged, { fg = src.fg, bg = bg_def.bg })
				return "%#" .. merged .. "#" .. icon .. " %#" .. bg_hl .. "#"
			end
			return icon .. " "
		end

		function stl.mode()
			local mode = vim.api.nvim_get_mode().mode
			local m = mode_map[mode] or { mode, "StlMode" }
			return "%#" .. m[2] .. "SepL#" .. SEP_L .. "%#" .. m[2] .. "# " .. m[1] .. " %#" .. m[2] .. "SepR#" .. SEP_R
		end

		function stl.file()
			local tail = vim.fn.expand("%:t")
			if tail == "" then
				tail = "[No Name]"
			end
			local name = tail
			if has_duplicate_name(tail) then
				name = vim.fn.expand("%:~:.")
			end
			local ext = vim.fn.expand("%:e")
			local icon = file_icon(tail, ext, "StlFile")
			local modified = vim.bo.modified and " +" or ""
			local readonly = (vim.bo.readonly or not vim.bo.modifiable) and " " or ""
			return "%#StlFile# " .. icon .. name .. modified .. readonly .. " %#StlFileSep#" .. SEP_R
		end

		function stl.git()
			local head = vim.b.gitsigns_head or vim.g.gitsigns_head
			if not head or head == "" then
				return ""
			end
			return "%#StlGit#  " .. head
		end

		function stl.diff()
			local s = vim.b.gitsigns_status_dict
			if not s then
				return ""
			end
			local parts = {}
			if (s.added or 0) > 0 then
				table.insert(parts, "%#StlDiffAdd# " .. s.added)
			end
			if (s.changed or 0) > 0 then
				table.insert(parts, "%#StlDiffChange# " .. s.changed)
			end
			if (s.removed or 0) > 0 then
				table.insert(parts, "%#StlDiffDelete# " .. s.removed)
			end
			return table.concat(parts, " ")
		end

		function stl.diag()
			local d = vim.diagnostic.count(0)
			local parts = {}
			if (d[1] or 0) > 0 then
				table.insert(parts, "%#StlDiagError# " .. d[1])
			end
			if (d[2] or 0) > 0 then
				table.insert(parts, "%#StlDiagWarn# " .. d[2])
			end
			if (d[3] or 0) > 0 then
				table.insert(parts, "%#StlDiagInfo# " .. d[3])
			end
			if (d[4] or 0) > 0 then
				table.insert(parts, "%#StlDiagHint#󰌶 " .. d[4])
			end
			return table.concat(parts, " ")
		end

		function stl.search()
			local ok, count = pcall(vim.fn.searchcount, { maxcount = 999 })
			if not ok or count.total == 0 then
				return ""
			end
			return "%#Comment# [" .. count.current .. "/" .. count.total .. "]"
		end

		function stl.tabline()
			local total = vim.fn.tabpagenr("$")
			if total <= 1 then
				return ""
			end
			local cur = vim.fn.tabpagenr()
			local s = ""
			for i = 1, total do
				local active = i == cur
				local hl = active and "StlTabActive" or "StlTabInactive"
				local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
				local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
				if name == "" then
					name = "[No Name]"
				end

				if i == 1 then
					s = s .. "%#" .. hl .. "SepL#" .. SEP_L
				else
					local prev_active = (i - 1) == cur
					local trans
					if prev_active and not active then
						trans = "StlTabA2I"
					elseif not prev_active and active then
						trans = "StlTabI2A"
					else
						trans = "StlTabI2I"
					end
					s = s .. "%#" .. trans .. "#" .. SEP_R
				end

				s = s .. "%#" .. hl .. "# " .. i .. " " .. name .. " "

				if i == total then
					local endhl = active and "StlTabActiveEnd" or "StlTabInactiveEnd"
					s = s .. "%#" .. endhl .. "#" .. SEP_R
				end
			end
			return s
		end

		-- Scope breadcrumbs (cached per buffer + cursor row)
		local scope_kinds = {
			-- generic
			function_declaration = true,
			function_definition = true,
			method_declaration = true,
			method_definition = true,
			class_declaration = true,
			class_definition = true,
			class_specifier = true,
			module = true,
			-- lua
			function_declaration_statement = true,
			-- rust
			function_item = true,
			struct_item = true,
			impl_item = true,
			enum_item = true,
			trait_item = true,
			mod_item = true,
			-- python
			decorated_definition = false,
			-- go
			type_declaration = true,
			-- js/ts
			interface_declaration = true,
			lexical_declaration = false,
			arrow_function = false,
			-- c/cpp
			namespace_definition = true,
		}

		local scope_cache = { bufnr = -1, row = -1, result = "" }

		local function compute_scope()
			local ok, ts = pcall(vim.treesitter.get_parser)
			if not ok or not ts then
				return ""
			end
			local cursor = vim.api.nvim_win_get_cursor(0)
			local row, col = cursor[1] - 1, cursor[2]
			local tree = ts:parse()[1]
			if not tree then
				return ""
			end
			local node = tree:root():named_descendant_for_range(row, col, row, col)
			local crumbs = {}
			while node do
				local kind = node:type()
				if scope_kinds[kind] then
					local name_node = node:field("name")[1]
					if name_node then
						table.insert(crumbs, 1, vim.treesitter.get_node_text(name_node, 0))
					else
						local parent = node:parent()
						if parent then
							local pt = parent:type()
							if pt == "field" or pt == "pair" then
								local key = parent:field("name")[1] or parent:field("key")[1]
								if key then
									table.insert(crumbs, 1, vim.treesitter.get_node_text(key, 0))
								end
							elseif pt == "assignment_statement" or pt == "variable_declaration" then
								local lhs = parent:named_child(0)
								if lhs then
									table.insert(crumbs, 1, vim.treesitter.get_node_text(lhs, 0))
								end
							end
						end
					end
				end
				node = node:parent()
			end
			if #crumbs == 0 then
				return ""
			end
			return "%#NonText# " .. table.concat(crumbs, " %#Comment#›%#NonText# ")
		end

		function stl.scope()
			local bufnr = vim.api.nvim_get_current_buf()
			local row = vim.api.nvim_win_get_cursor(0)[1]
			if scope_cache.bufnr == bufnr and scope_cache.row == row then
				return scope_cache.result
			end
			local result = compute_scope()
			scope_cache.bufnr = bufnr
			scope_cache.row = row
			scope_cache.result = result
			return result
		end

		vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
			callback = function()
				scope_cache.bufnr = -1
			end,
		})

		function stl.winbar()
			local tail = vim.fn.expand("%:t")
			if tail == "" then
				tail = "[No Name]"
			end
			local active = tostring(vim.api.nvim_get_current_win()) == tostring(vim.g.actual_curwin)
			local hl = active and "WbActive" or "WbInactive"
			local ext = vim.fn.expand("%:e")
			local icon = file_icon(tail, ext, hl)
			local modified = vim.bo.modified and " +" or ""
			local pill = "%#"
				.. hl
				.. "SepL#"
				.. SEP_L
				.. "%#"
				.. hl
				.. "# "
				.. icon
				.. tail
				.. modified
				.. " %#"
				.. hl
				.. "SepR#"
				.. SEP_R
			local scope = active and stl.scope() or ""
			return scope .. "%=" .. pill
		end

		function stl.ft()
			local ft = vim.bo.filetype
			if ft == "" then
				return ""
			end
			return "%#Comment#" .. ft .. " "
		end

		function stl.pos()
			local mode = vim.api.nvim_get_mode().mode
			local m = mode_map[mode] or { mode, "StlMode" }
			local hl = "StlPos" .. m[2]
			return "%#StlProgressSepL#"
				.. SEP_L
				.. "%#StlProgress# %p%% "
				.. "%#"
				.. hl
				.. "SepL#"
				.. SEP_L
				.. "%#"
				.. hl
				.. "#  %l:%c "
				.. "%#"
				.. hl
				.. "SepR#"
				.. SEP_R
		end

		vim.o.winbar = "%{%v:lua._stl.winbar()%}"

		vim.o.showtabline = 1
		vim.o.tabline = "%=%{%v:lua._stl.tabline()%}%="

		vim.o.statusline = table.concat({
			"%{%v:lua._stl.mode()%}",
			" %{%v:lua._stl.file()%}",
			" %{%v:lua._stl.git()%}",
			" %{%v:lua._stl.diff()%}",
			"%=",
			"%S ",
			"%{%v:lua._stl.search()%} ",
			"%{%v:lua._stl.diag()%} ",
			"%{%v:lua._stl.pos()%}",
		})
	end,
}
