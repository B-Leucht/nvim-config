return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff (all files)" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current)" },
    { "<leader>gF", "<cmd>DiffviewFileHistory<CR>", desc = "File history (repo)" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  },
}
