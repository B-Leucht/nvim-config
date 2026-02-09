vim.g.python3_host_prog = vim.fn.expand("~/.venvs/neovim/bin/python")
vim.env.PYTHONSTARTUP = nil

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.cmdheight = 0
vim.g.custom_lualine_show_lsp_names = true

local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.number = true
opt.relativenumber = true
opt.numberwidth = 1
opt.signcolumn = "auto:2"
opt.foldcolumn = "0"
opt.cursorline = true
opt.wrap = false
opt.textwidth = 80
opt.formatoptions = "tcqjrn1"
opt.wrapmargin = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.conceallevel = 2
opt.concealcursor = ""

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.mouse = "a"
opt.mousemodel = "popup"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.backup = true
opt.backupdir = vim.fn.stdpath("config") .. "/backup/"
opt.swapfile = false

opt.splitbelow = true
opt.splitright = true

opt.termguicolors = true
opt.showmode = false
opt.laststatus = 2
vim.o.winborder = "rounded"

opt.updatetime = 1000
opt.timeoutlen = 400

local term_program = os.getenv("TERM_PROGRAM")
if term_program == "iTerm.app" or term_program == "Apple_Terminal" then
	vim.opt.ttyfast = true
	vim.opt.ttimeout = true
end

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = function(diagnostic)
			local icons = { "󰅚", "󰀪", "󰋽", "󰌶" }
			return icons[diagnostic.severity]
		end,
		format = function(diagnostic)
			local max_width = 60
			local message = diagnostic.message:gsub("\n", " ")
			if #message > max_width then
				message = message:sub(1, max_width) .. "…"
			end
			return message
		end,
	},
	float = {
		focusable = false,
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "rounded",
		source = "always",
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
	update_in_insert = false,
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

vim.g.markdown_fenced_languages = {
	"python",
	"lua",
	"bash",
	"sh",
	"json",
	"vim",
}

vim.opt.spell = true
vim.opt.spelllang = { "en", "de" }
