return {
  "chrisgrieser/nvim-recorder",
  event = "VeryLazy",
  opts = {
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
  },
}
