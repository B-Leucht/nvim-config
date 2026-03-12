return {
  "igorlfs/nvim-dap-view",
  opts = {
    winbar = {
      controls = {
        enabled = true,
      },
    },
  },
  keys = { {
    "<leader>du",
    "<cmd>DapViewToggle<cr>",
    desc = "Toggle DAP-View",
  } },
}
