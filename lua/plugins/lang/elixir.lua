-- Elixir development
return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "elixir", "eelixir", "heex", "surface" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local elixir = require("elixir")
    local nextls = require("elixir.nextls")

    elixir.setup({
      nextls = {
        enable = true,
        init_options = {
          experimental = {
            completions = { enable = true },
          },
        },
      },
      elixirls = { enable = false },
      projectionist = { enable = false },
    })
  end,
}
