local parsers = {
  "latex",
  "nu",
  "python",
  "java",
  "json",
  "bash",
  "yaml",
  "cpp",
  "c",
  "haskell",
  "markdown",
  "markdown_inline",
  "rust",
  "toml",
  "lua",
  "vim",
  "vimdoc",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  "scss",
  "svelte",
  "typst",
  "vue",
  "elixir",
  "heex",
  "eex",
  "diff",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "make",
  "xml",
  "php",
  "zig",
  "sql",
  "dockerfile",
  "jsdoc",
  "regex",
  "query",
  "ssh_config",
  "tmux",
  "cmake",
  "proto",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")
      -- Install essential parsers
      ts.install({ "markdown", "markdown_inline", "python", "lua" })
      -- Create command to install all parsers
      vim.api.nvim_create_user_command("TSInstallAll", function()
        ts.install(parsers)
      end, { desc = "Install all configured treesitter parsers" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      max_lines = 3,
      min_window_height = 20,
    },
    keys = {
      {
        "<leader>uc",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
