return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>we",
      function()
        require("edgy").toggle()
      end,
      desc = "Toggle Edgy",
    },
    {
      "<leader>wE",
      function()
        require("edgy").select()
      end,
      desc = "Select Edgy Window",
    },
  },
  opts = {
    bottom = {
      {
        ft = "OverseerList",
        title = "Overseer",
        size = { height = 0.3 },
        open = "OverseerToggle",
      },
      {
        ft = "terminal",
        title = "Terminal",
        size = { height = 0.3 },
        filter = function(_, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      { ft = "qf", title = "Quickfix" },
      { ft = "help", title = "Help", size = { height = 0.4 } },
    },
    right = {
      {
        ft = "dap-view",
        title = "Debugger",
        size = { width = 0.3 },
        open = "DapViewOpen",
      },
      {
        ft = "dap-repl",
        title = "DAP REPL",
        size = { width = 0.3 },
      },
    },
    animate = { enabled = false },
    exit_when_last = true,
    wo = {
      winbar = true,
      winhighlight = "",
      winfixbuf = true,
    },
  },
}
