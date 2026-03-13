return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown" },
    opts = {
      lsp = {
        diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
      },
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      handle_leading_whitespace = true,
    },
    config = function(_, opts)
      require("otter").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function(args)
          -- Guard against duplicate activation (E95: buffer name already exists)
          if vim.b[args.buf].otter_activated then
            return
          end
          local ok, err = pcall(require("otter").activate)
          if ok then
            vim.b[args.buf].otter_activated = true
          else
            vim.notify("otter activation failed: " .. tostring(err), vim.log.levels.WARN)
          end
        end,
      })
    end,
  },
}
