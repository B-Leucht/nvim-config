return {
  "Olical/conjure",
  enabled = true,
  ft = {
    -- Only keep languages that lack good LSP support or need REPL interaction
    "clojure",
    "fennel",
    "janet",
    "racket",
    "scheme",
    "julia",
    "sql",
  },
  init = function()
    -- Disable all LSP-provided features since we use LSP everywhere
    vim.g["conjure#mapping#doc_word"] = false
    vim.g["conjure#mapping#def_word"] = false
    vim.g["conjure#mapping#completions"] = false

    -- Only keep REPL-focused mappings
    -- vim.g["conjure#mapping#prefix"] = "<leader>e"
    -- vim.g["conjure#mapping#eval_form"] = "e"
    -- vim.g["conjure#mapping#eval_file"] = "f"
    -- vim.g["conjure#mapping#eval_buffer"] = "b"
    -- vim.g["conjure#mapping#eval_visual"] = "E"
    -- vim.g["conjure#mapping#eval_word"] = "w"
    -- vim.g["conjure#mapping#eval_mark"] = "m"
    -- vim.g["conjure#mapping#log_split"] = "ls"
    -- vim.g["conjure#mapping#log_vsplit"] = "lv"
    -- vim.g["conjure#mapping#log_tab"] = "lt"
    -- vim.g["conjure#mapping#log_toggle"] = "lg"
  end,
}
