-- Nabla mathematical notation keymaps
return {
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
}