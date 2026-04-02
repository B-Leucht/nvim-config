local gh = require("utils.gh")

return {
	specs = { gh("chrisgrieser/nvim-recorder") },
	setup = function()
		require("recorder").setup({
			useNerdfontIcons = true,
			mapping = {
				startStopRecording = "q",
				playMacro = "Q",
				switchSlot = "<C-q>",
				editMacro = "<leader>Mc",
				yankMacro = "<leader>My",
				deleteAllMacros = "<leader>Md",
				addBreakPoint = "##",
			},
		})
	end,
}
