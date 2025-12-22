-- Markdown support
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = "markdown",
	opts = {
		-- Render all lines except cursor line (anti-conceal)
		anti_conceal = {
			enabled = true,
		},
	},
	config = function(_, opts)
		require("render-markdown").setup(opts)

		-- Set conceallevel for markdown files only
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.opt_local.conceallevel = 2
				vim.opt_local.concealcursor = "i" -- Show raw text only in insert mode
			end,
		})
	end,
},

-- Mathematical notation rendering
{
	"jbyuki/nabla.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"williamboman/mason.nvim",
	},
	ft = "markdown",
	keys = {
		{ "<leader>p", function()
			-- Toggle Nabla and RenderMarkdown logic
			local current_tool = vim.g.current_preview_tool
			if current_tool == "nabla" then
				require("nabla").disable_virt()
				require("render-markdown").enable()
				vim.g.current_preview_tool = "render-markdown"
				return
			elseif current_tool == "render-markdown" then
				require("render-markdown").disable()
				require("nabla").enable_virt({ autogen = true })
				vim.g.current_preview_tool = "nabla"
				return
			end
			-- Default: start with Nabla
			require("nabla").enable_virt({ autogen = true })
			vim.g.current_preview_tool = "nabla"
		end, desc = "Toggle Nabla / RenderMarkdown preview" },
	},
}