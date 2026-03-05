-- Annotation/docstring generator
return {
  "danymat/neogen",
  cmd = "Neogen",
  keys = {
    { "<leader>cn", function() require("neogen").generate() end, desc = "Generate annotation" },
  },
  opts = {
    snippet_engine = "nvim",
  },
}
