return {
	"mrcjkb/haskell-tools.nvim",
	version = "^7",
	lazy = false,
	init = function()
		vim.g.haskell_tools = {
			hls = {
				on_attach = function(_, bufnr)
					local ht = require("haskell-tools")
					local opts = function(desc)
						return { buffer = bufnr, desc = desc }
					end
					vim.lsp.codelens.refresh({ bufnr = bufnr })
					vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
						buffer = bufnr,
						callback = function()
							vim.lsp.codelens.refresh({ bufnr = bufnr })
						end,
					})
					vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts("Run code lens"))
					vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, opts("Hoogle signature"))
					vim.keymap.set("n", "<leader>ea", ht.lsp.buf_eval_all, opts("Evaluate all snippets"))
					vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts("Toggle GHCi repl"))
					vim.keymap.set("n", "<leader>rf", function()
						ht.repl.toggle(vim.api.nvim_buf_get_name(0))
					end, opts("Toggle GHCi repl (buffer)"))
					vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts("Quit GHCi repl"))
				end,
				settings = {
					haskell = {
						plugin = {
							["ghcide-type-lenses"] = {
								globalOn = true,
								config = { mode = "always" },
							},
							importLens = {
								globalOn = false,
							},
							["explicit-fields"] = {
								globalOn = false,
							},
						},
					},
				},
			},
		}
	end,
}
