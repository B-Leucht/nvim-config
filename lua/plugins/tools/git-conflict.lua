return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPost",
  opts = {
    default_mappings = {
      ours = "co",
      theirs = "ct",
      none = "c0",
      both = "cb",
      next = "]x",
      prev = "[x",
    },
  },
}
