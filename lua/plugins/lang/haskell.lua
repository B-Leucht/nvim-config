return {
	"mrcjkb/haskell-tools.nvim",
	ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
	init = function()
		vim.g.haskell_tools = {
			hls = {
				on_attach = function(_, bufnr)
					local ht = require("haskell-tools")
					local opts = function(desc)
						return { buffer = bufnr, desc = desc }
					end
					vim.keymap.set("n", "<localleader>hs", ht.hoogle.hoogle_signature, opts("Hoogle signature"))
					vim.keymap.set("n", "<localleader>he", ht.lsp.buf_eval_all, opts("Evaluate all snippets"))
					vim.keymap.set("n", "<localleader>hr", ht.repl.toggle, opts("Toggle GHCi repl"))
					vim.keymap.set("n", "<localleader>hf", function()
						ht.repl.toggle(vim.api.nvim_buf_get_name(0))
					end, opts("Toggle GHCi repl (buffer)"))
					vim.keymap.set("n", "<localleader>hq", ht.repl.quit, opts("Quit GHCi repl"))
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
