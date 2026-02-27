vim.g.python3_host_prog = vim.fn.expand("~/.venvs/neovim/bin/python")
vim.env.PYTHONSTARTUP = nil

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.cmdheight = 0
local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 1
opt.signcolumn = "auto:2"
opt.foldcolumn = "2"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.cursorline = true
opt.wrap = true
opt.textwidth = 80
opt.formatoptions = "tcqjrn1"
opt.wrapmargin = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.conceallevel = 2
opt.concealcursor = ""

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
opt.backupdir = vim.fn.stdpath("config") .. "/backup/"
opt.swapfile = false

opt.splitbelow = true
opt.splitright = true

opt.showmode = false
vim.o.winborder = "rounded"

opt.updatetime = 250
opt.timeoutlen = 400

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { current_line = true },
	float = {
		focusable = false,
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "rounded",
		source = true,
		prefix = " ",
		scope = "cursor",
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

vim.opt.spelllang = { "en", "de" }
