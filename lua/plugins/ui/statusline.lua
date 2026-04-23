local SEP_L = "\u{e0b6}" --
local SEP_R = "\u{e0b4}" --

return {
	specs = {},
	setup = function()
		vim.o.laststatus = 3

		local function setup_highlights()
			-- synIDtrans follows highlight links, synIDattr with "#" returns gui hex color
			local function fg(name)
				local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(name)), "fg#")
				return color ~= "" and color or "NONE"
			end
			local function bg(name)
				local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(name)), "bg#")
				return color ~= "" and color or nil
			end

			-- Normal bg may be NONE in transparent themes — fall back by background tone
			local base    = bg("Normal") or (vim.o.background == "light" and "#ffffff" or "#000000")
			local surface = bg("CursorLine") or bg("Pmenu") or bg("StatusLine") or "NONE"
			local text    = fg("Normal")
			local overlay = fg("Comment")
			local blue    = fg("Function")
			local green   = fg("String")
			local mauve   = fg("Keyword")
			local red     = fg("DiagnosticError")
			local peach   = fg("Number")
			local teal    = fg("DiagnosticHint")
			local flamingo = fg("Character")
			local yellow  = fg("DiagnosticWarn")

			local mode_colors = {
				StlMode  = blue,
				StlModeI = green,
				StlModeV = mauve,
				StlModeR = red,
				StlModeC = peach,
				StlModeT = teal,
			}

			-- Mode section
			for hl, col in pairs(mode_colors) do
				vim.api.nvim_set_hl(0, hl, { fg = base, bg = col, bold = true })
				vim.api.nvim_set_hl(0, hl .. "SepL", { fg = col, bg = "NONE" })
				vim.api.nvim_set_hl(0, hl .. "SepR", { fg = col, bg = surface })
			end

			-- File section (connected to mode)
			vim.api.nvim_set_hl(0, "StlFile", { fg = text, bg = surface })
			vim.api.nvim_set_hl(0, "StlFileSep", { fg = surface, bg = "NONE" })

			-- Middle (no bg)
			vim.api.nvim_set_hl(0, "StlGit", { fg = flamingo, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiffAdd", { fg = green, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiffChange", { fg = yellow, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiffDelete", { fg = red, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagError", { fg = red, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagWarn", { fg = yellow, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagInfo", { fg = blue, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlDiagHint", { fg = teal, bg = "NONE" })

			-- Progress → Position connected block (position uses mode color)
			vim.api.nvim_set_hl(0, "StlProgressSepL", { fg = surface, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlProgress", { fg = text, bg = surface })
			for hl, col in pairs(mode_colors) do
				vim.api.nvim_set_hl(0, "StlPos" .. hl, { fg = base, bg = col, bold = true })
				vim.api.nvim_set_hl(0, "StlPos" .. hl .. "SepL", { fg = col, bg = surface })
				vim.api.nvim_set_hl(0, "StlPos" .. hl .. "SepR", { fg = col, bg = "NONE" })
			end

			-- Winbar: transparent bg (matches statusbar between-pill area), surface pill
			vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbActive", { fg = text, bg = surface })
			vim.api.nvim_set_hl(0, "WbActiveSepL", { fg = surface, bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbActiveSepR", { fg = surface, bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbInactive", { fg = overlay, bg = surface })
			vim.api.nvim_set_hl(0, "WbInactiveSepL", { fg = surface, bg = "NONE" })
			vim.api.nvim_set_hl(0, "WbInactiveSepR", { fg = surface, bg = "NONE" })

			-- Tabline: outer bar is surface pill, active tab is blue pill inside
			vim.api.nvim_set_hl(0, "StlTabBar", { fg = overlay, bg = surface })
			vim.api.nvim_set_hl(0, "StlTabDiv", { fg = overlay, bg = surface })
			vim.api.nvim_set_hl(0, "StlTabBarSepL", { fg = surface, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlTabBarSepR", { fg = surface, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlTabActive", { fg = base, bg = blue, bold = true })
			vim.api.nvim_set_hl(0, "StlTabActiveSepL", { fg = blue, bg = surface })
			vim.api.nvim_set_hl(0, "StlTabActiveSepR", { fg = blue, bg = surface })
			vim.api.nvim_set_hl(0, "StlTabActiveEdgeL", { fg = blue, bg = "NONE" })
			vim.api.nvim_set_hl(0, "StlTabActiveEdgeR", { fg = blue, bg = "NONE" })
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

		-- Click handlers (must be global for %@func@ syntax)
		function _G._stl_click_buffers(_, _, btn)
			if btn == "l" then
				require("snacks").picker.buffers()
			end
		end
		function _G._stl_click_diag(_, _, btn)
			if btn == "l" then
				vim.diagnostic.setloclist()
			end
		end
		function _G._stl_click_git_branch(_, _, btn)
			if btn == "l" then
				require("snacks").picker.git_branches()
			end
		end
		function _G._stl_click_git_status(_, _, btn)
			if btn == "l" then
				require("snacks").picker.git_status()
			end
		end
		-- Store scope node start positions for click-to-jump
		stl._scope_positions = {}
		function _G._stl_click_scope(minwid, _, btn)
			if btn == "l" then
				local pos = stl._scope_positions[minwid]
				if pos then
					vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
				end
			end
		end

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
			return "%@v:lua._stl_click_buffers@%#StlFile# " .. icon .. name .. modified .. readonly .. " %#StlFileSep#" .. SEP_R .. "%X"
		end

		function stl.git()
			local head = vim.b.gitsigns_head or vim.g.gitsigns_head
			if not head or head == "" then
				return ""
			end
			return "%@v:lua._stl_click_git_branch@%#StlGit#  " .. head .. "%X"
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
			local result = table.concat(parts, " ")
			if result ~= "" then
				result = "%@v:lua._stl_click_git_status@" .. result .. "%X"
			end
			return result
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
			local result = table.concat(parts, " ")
			if result ~= "" then
				result = "%@v:lua._stl_click_diag@" .. result .. "%X"
			end
			return result
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
			-- Build tab content, collect labels and widths
			local tabs = {}
			local total_width = 0
			for i = 1, total do
				local active = i == cur
				local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
				local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
				if name == "" then
					name = "[No Name]"
				end
				local label = " " .. i .. " " .. name .. " "
				local w = #label + (active and 2 or 0) -- +2 for pill separators
				if not active and i > 1 and not tabs[i - 1].active then
					w = w + 1 -- divider
				end
				-- outer bar separators only on inactive edges
				if i == 1 and not active then
					w = w + 1 -- bar left sep
				end
				if i == total and not active then
					w = w + 1 -- bar right sep
				end
				total_width = total_width + w
				tabs[i] = { label = label, active = active }
			end

			-- Distribute padding evenly across all tabs
			local cols = vim.o.columns
			local extra = math.max(0, cols - total_width)
			local per_tab = math.floor(extra / total)
			local remainder = extra - per_tab * total

			local s = ""
			local prev_active = false
			for i = 1, total do
				local t = tabs[i]
				local is_first = i == 1
				local is_last = i == total
				local pad = per_tab + (i <= remainder and 1 or 0)
				local lpad = math.floor(pad / 2)
				local rpad = pad - lpad
				s = s .. "%" .. i .. "T"
				if t.active then
					local sepl = is_first and "StlTabActiveEdgeL" or "StlTabActiveSepL"
					local sepr = is_last and "StlTabActiveEdgeR" or "StlTabActiveSepR"
					s = s .. "%#" .. sepl .. "#" .. SEP_L
					s = s .. "%#StlTabActive#" .. string.rep(" ", lpad) .. t.label .. string.rep(" ", rpad)
					s = s .. "%#" .. sepr .. "#" .. SEP_R
				else
					if is_first then
						s = s .. "%#StlTabBarSepL#" .. SEP_L
					elseif not prev_active then
						s = s .. "%#StlTabDiv#│"
					end
					s = s .. "%#StlTabBar#" .. string.rep(" ", lpad) .. t.label .. string.rep(" ", rpad)
					if is_last then
						s = s .. "%#StlTabBarSepR#" .. SEP_R
					end
				end
				s = s .. "%T"
				prev_active = t.active
			end
			return s
		end

		-- Scope breadcrumbs (cached per buffer + cursor row)
		-- value = { hl, icon } or false to skip
		local scope_kinds = {
			-- generic
			function_declaration = { "@function", "󰊕" },
			function_definition = { "@function", "󰊕" },
			method_declaration = { "@function.method", "󰊕" },
			method_definition = { "@function.method", "󰊕" },
			class_declaration = { "@type", "" },
			class_definition = { "@type", "" },
			class_specifier = { "@type", "" },
			module = { "@module", "󰅩" },
			-- lua
			function_declaration_statement = { "@function", "󰊕" },
			-- rust
			function_item = { "@function", "󰊕" },
			struct_item = { "@type", "" },
			impl_item = { "@type", "" },
			enum_item = { "@type", "" },
			trait_item = { "@type", "" },
			mod_item = { "@module", "󰅩" },
			-- python
			decorated_definition = false,
			-- go
			type_declaration = { "@type", "" },
			-- js/ts
			interface_declaration = { "@type", "" },
			lexical_declaration = false,
			arrow_function = false,
			-- c/cpp
			namespace_definition = { "@module", "󰅩" },
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
			stl._scope_positions = {}
			while node do
				local kind = node:type()
				local kind_info = scope_kinds[kind]
				if kind_info then
					local kind_hl, kind_icon = kind_info[1], kind_info[2]
					local name_node = node:field("name")[1]
					local label
					if name_node then
						label = vim.treesitter.get_node_text(name_node, 0)
					else
						local parent = node:parent()
						if parent then
							local pt = parent:type()
							if pt == "field" or pt == "pair" then
								local key = parent:field("name")[1] or parent:field("key")[1]
								if key then
									label = vim.treesitter.get_node_text(key, 0)
								end
							elseif pt == "assignment_statement" or pt == "variable_declaration" then
								local lhs = parent:named_child(0)
								if lhs then
									label = vim.treesitter.get_node_text(lhs, 0)
								end
							end
						end
					end
					if label then
						local sr, sc = node:start()
						table.insert(crumbs, 1, { label = label, row = sr, col = sc, hl = kind_hl, icon = kind_icon })
					end
				end
				node = node:parent()
			end
			if #crumbs == 0 then
				return ""
			end
			local parts = {}
			for idx, c in ipairs(crumbs) do
				stl._scope_positions[idx] = { c.row, c.col }
				table.insert(parts, "%" .. idx .. "@v:lua._stl_click_scope@%#" .. c.hl .. "#" .. c.icon .. " " .. c.label .. "%X")
			end
			return " " .. table.concat(parts, " %#Comment#› ")
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
			local pill = "%@v:lua._stl_click_buffers@%#"
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
				.. "%X"
			return "%=" .. pill
		end

		function stl.ft()
			local ft = vim.bo.filetype
			if ft == "" then
				return ""
			end
			return "%#Comment#" .. ft .. " "
		end

		-- Minuet AI completion status
		local minuet_state = { processing = false, name = "", spinner = 1 }
		local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		local minuet_group = vim.api.nvim_create_augroup("StlMinuet", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			pattern = "MinuetRequestStartedPre",
			group = minuet_group,
			callback = function(ev)
				minuet_state.processing = false
				minuet_state.name = ev.data.name
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "MinuetRequestStarted",
			group = minuet_group,
			callback = function()
				minuet_state.processing = true
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "MinuetRequestFinished",
			group = minuet_group,
			callback = function()
				minuet_state.processing = false
			end,
		})

		function stl.minuet()
			if not minuet_state.processing then
				return ""
			end
			minuet_state.spinner = (minuet_state.spinner % #spinners) + 1
			return "%#Comment#" .. minuet_state.name .. " " .. spinners[minuet_state.spinner] .. " "
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
			"%{%v:lua._stl.minuet()%}",
			"%{%v:lua._stl.search()%} ",
			"%{%v:lua._stl.diag()%} ",
			"%{%v:lua._stl.pos()%}",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "qf" },
			callback = function()
				vim.wo.statusline = "%{%v:lua._stl.mode()%} %#StlFile# Quickfix %#StlFileSep#" .. SEP_R .. "%=%{%v:lua._stl.pos()%}"
			end,
		})
	end,
}
