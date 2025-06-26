vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = "abdmg"
vim.g.vimtex_compiler_latexmk = {
	build_dir = "",
	callback = 1,
	continuous = 1,
	executable = "latexmk",
	options = { "-pdflua", "-interaction=nonstopmode", "-synctex=1" },
}

vim.cmd([[
  autocmd BufNewFile,BufRead *.tex VimtexCompile
]])
