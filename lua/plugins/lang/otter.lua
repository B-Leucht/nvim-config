-- Otter.nvim - LSP features for embedded code blocks
return {
	{
		"jmbuhr/otter.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "markdown" },
		opts = {
			lsp = {
				diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
			},
			buffers = {
				set_filetype = true,
				write_to_disk = false,
			},
			handle_leading_whitespace = true,
		},
		config = function(_, opts)
			require("otter").setup(opts)

			-- Filter out noisy diagnostics for otter/markdown buffers
			local ignored_diagnostics = {
				"reportUnreachable",
				"reportPossiblyUnbound",
				"reportUnusedExpression",
				"Unreachable code",
				"Expression value is unused",
			}

			local function filter_diagnostics(diagnostics, bufnr)
				if vim.bo[bufnr].filetype ~= "markdown" then
					return diagnostics
				end
				return vim.tbl_filter(function(d)
					for _, ignored in ipairs(ignored_diagnostics) do
						if d.message:find(ignored) or (d.code and tostring(d.code):find(ignored)) then
							return false
						end
					end
					return true
				end, diagnostics)
			end

			-- Wrap all diagnostic handlers
			local handlers = { "virtual_text", "underline", "signs" }
			for _, name in ipairs(handlers) do
				local original = vim.diagnostic.handlers[name]
				if original then
					vim.diagnostic.handlers[name] = {
						show = function(ns, bufnr, diagnostics, opts)
							original.show(ns, bufnr, filter_diagnostics(diagnostics, bufnr), opts)
						end,
						hide = original.hide,
					}
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "markdown" },
				callback = function(args)
					-- Guard against duplicate activation (E95: buffer name already exists)
					if vim.b[args.buf].otter_activated then
						return
					end
					local ok = pcall(require("otter").activate)
					if ok then
						vim.b[args.buf].otter_activated = true
					end
				end,
			})
		end,
	},
}
