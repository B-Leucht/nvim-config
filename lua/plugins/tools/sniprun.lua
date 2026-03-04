return {
  "michaelb/sniprun",
  build = "bash install.sh",
  cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipClose", "SnipReplMemoryClean", "SnipLive" },
  keys = {
    { "<leader>x", "<Plug>SnipRun", desc = "Execute code snippet", mode = { "n", "v" } },
    { "<leader>X", "<Plug>SnipRunOperator", desc = "Execute code with operator" },
    { "<leader>xc", "<cmd>SnipClose<cr>", desc = "Close sniprun output" },
    { "<leader>xi", "<cmd>SnipInfo<cr>", desc = "Show sniprun info" },
    { "<leader>xm", "<cmd>SnipReplMemoryClean<cr>", desc = "Clean REPL memory" },
    { "<leader>xl", "<cmd>SnipLive<cr>", desc = "Toggle live mode" },
    { "<leader>xr", "<cmd>lua require('sniprun').clear_repl()<cr>", desc = "Reset REPL" },
  },
  opts = {
    -- Use interpreters with good REPL support
    selected_interpreters = { "Lua_nvim", "Python3_fifo", "Rust_original" },
    repl_enable = { "Lua_nvim", "Python3_fifo", "Rust_original" },

    interpreter_options = {
      Lua_nvim = {
        -- Use nvim's Lua interpreter
        error_truncate = "auto",
      },
      Python3_fifo = {
        -- Use uv venv Python if available
        interpreter = function()
          local venv_path = os.getenv("VIRTUAL_ENV")
          if venv_path then
            local python_exe = venv_path .. "/bin/python"
            if vim.fn.executable(python_exe) == 1 then
              return python_exe
            end
          end
          return "python3"
        end,
        error_truncate = "auto",
      },
      Rust_original = {
        -- Use evcxr for Rust REPL
        interpreter = "evcxr",
      },
    },
    display = {
      "TerminalWithCode", -- Shows code and output together
      "Classic", -- Also show in command line for quick feedback
    },
    display_options = {
      terminal_width = 100,
      terminal_height = 20,
      terminal_position = "vertical",
      terminal_line_number = false,
      terminal_signcolumn = false,
    },
    -- Live mode configuration (disabled by default for safety)
    live_mode_toggle = "off",
    live_display = { "VirtualTextOk" },

    -- Show no output handling
    show_no_output = {
      "Classic",
    },

    -- ANSI color support
    ansi_escape = true,

    -- Border style for floating windows
    borders = "single",
  },
  config = function()
    -- Set up custom highlight groups
    vim.api.nvim_set_hl(
      0,
      "SniprunVirtualTextOk",
      { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", ctermfg = "Black" }
    )
    vim.api.nvim_set_hl(0, "SniprunFloatingWinOk", { fg = "#66eeff", ctermfg = "Cyan" })
    vim.api.nvim_set_hl(
      0,
      "SniprunVirtualTextErr",
      { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" }
    )
    vim.api.nvim_set_hl(0, "SniprunFloatingWinErr", { fg = "#881515", ctermfg = "DarkRed", bold = true })

    -- Initialize REPL when entering supported files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "lua", "rust" },
      callback = function(args)
        local ft = args.match
        -- Force REPL initialization
        vim.defer_fn(function()
          require("sniprun").clear_repl()
          -- Test the REPL with a simple command
          if ft == "python" then
            require("sniprun.api").run_string("print('Python REPL initialized')", "python")
          elseif ft == "lua" then
            require("sniprun.api").run_string("print('Lua REPL initialized')", "lua")
          elseif ft == "rust" then
            require("sniprun.api").run_string('println!("Rust REPL initialized")', "rust")
          end
        end, 200)
      end,
    })
  end,
}
