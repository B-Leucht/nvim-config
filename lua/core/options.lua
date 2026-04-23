vim.g.python3_host_prog = vim.fn.expand("~/.venvs/neovim/bin/python")
vim.env.PYTHONSTARTUP = nil

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.cmdheight = 0
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"
local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 1
opt.signcolumn = "auto:1"
opt.foldcolumn = "0"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = ""
opt.cursorline = true
opt.wrap = true
opt.textwidth = 80
opt.formatoptions = "tcqjrn1"
opt.wrapmargin = 0
opt.concealcursor = ""

opt.inccommand = "split"
opt.jumpoptions = "stack"
opt.smoothscroll = true
opt.ignorecase = true
opt.smartcase = true

opt.mousemodel = "popup"

-- Override built-in right-click "Show All Diagnostics" to handle deleted buffers (otter.nvim)
vim.cmd([[
  aunmenu PopUp.Show\ All\ Diagnostics
  amenu PopUp.Show\ All\ Diagnostics <cmd>lua pcall(vim.diagnostic.setqflist)<CR>
]])
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.backup = true
opt.backupdir = vim.fn.stdpath("state") .. "/backup/"
opt.swapfile = false

opt.splitbelow = true
opt.splitright = true
opt.breakindent = true
opt.exrc = true

opt.showmode = false
vim.o.winborder = "rounded"
vim.o.wrap = true

opt.updatetime = 250
opt.timeoutlen = 400

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	float = {
		focusable = true,
		border = "rounded",
		source = true,
		prefix = " ",
		scope = "line",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
	underline = true,
	severity_sort = true,
})

if vim.g.neovide then
	if vim.fn.has("macunix") == 1 then
		vim.g.neovide_input_use_logo = 1
		vim.g.neovide_input_macos_options_key_is_meta = "only_left"
	end

	vim.g.neovide_title_hidden = 1
	vim.g.neovide_frame = "buttonless"
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_opacity = 0.95
	vim.g.neovide_scale_factor = 1.0
	vim.o.guifont = "FiraCode Nerd Font:h18"
end

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

vim.opt.spelllang = { "en", "de" }

-- Cursorline only in active window
local cursorline_group = vim.api.nvim_create_augroup("ActiveCursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- Auto-save on focus lost / buffer leave
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
	callback = function(ev)
		local buf = ev.buf
		if vim.bo[buf].modified and vim.bo[buf].buftype == "" and vim.bo[buf].modifiable then
			local name = vim.api.nvim_buf_get_name(buf)
			if name ~= "" then
				vim.api.nvim_buf_call(buf, function()
					vim.cmd("silent! write")
				end)
			end
		end
	end,
})

-- Auto-close stale buffers (unvisited for 30+ minutes)
local buf_last_used = {}
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("StaleBuffers", { clear = true }),
	callback = function(ev)
		buf_last_used[ev.buf] = vim.uv.now()
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = "StaleBuffers",
	callback = function()
		local now = vim.uv.now()
		local threshold = 30 * 60 * 1000 -- 30 minutes
		for buf, last in pairs(buf_last_used) do
			if
				vim.api.nvim_buf_is_valid(buf)
				and vim.bo[buf].buflisted
				and vim.bo[buf].buftype == ""
				and not vim.bo[buf].modified
				and buf ~= vim.api.nvim_get_current_buf()
				and (now - last) > threshold
			then
				vim.api.nvim_buf_delete(buf, {})
				buf_last_used[buf] = nil
			end
		end
	end,
})
