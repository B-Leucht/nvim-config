return {
  "m4xshen/hardtime.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    max_count = 3,
    disable_mouse = false,
    restricted_keys = {
      ["h"] = { "n", "x" },
      ["j"] = { "n", "x" },
      ["k"] = { "n", "x" },
      ["l"] = { "n", "x" },
    },
  },
  keys = {
    { "<leader>uH", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
  },
}
