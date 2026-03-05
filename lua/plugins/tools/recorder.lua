-- Better macro management
return {
  "chrisgrieser/nvim-recorder",
  event = "VeryLazy",
  opts = {
    mapping = {
      startStopRecording = "q",
      playMacro = "Q",
      switchSlot = "<C-q>",
      editMacro = "cq",
      deleteAllMacros = "dq",
    },
  },
}
