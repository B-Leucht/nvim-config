return {
	"Davidyz/inlayhint-filler.nvim",
	event = "LspAttach",
	opts = {},
	config = function()
		-- Fix for Neovim 0.11.6 inlay hint column out of range error
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					-- Add a small delay to ensure buffer is properly initialized
					vim.defer_fn(function()
						pcall(function()
							vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
						end)
					end, 100)
				end
			end,
		})
	end,
}
