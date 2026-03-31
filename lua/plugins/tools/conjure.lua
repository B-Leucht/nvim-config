local gh = function(x) return "https://github.com/" .. x end

return {
	specs = { gh("Olical/conjure") },
	init = function()
		vim.g["conjure#mapping#doc_word"] = false
		vim.g["conjure#mapping#def_word"] = false
		vim.g["conjure#mapping#completions"] = false
	end,
}
