local gh = require("utils.gh")

return {
  specs = {
    gh("milanglacier/minuet-ai.nvim"),
  },
  setup = function()
    require("minuet").setup({
      blink = { enable_auto_complete = false },
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 4096,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          end_point = "http://127.0.0.1:8080/v1/completions",
          model = "qwen2.5-coder-14b-instruct-q4_k_m",
          name = "llama.cpp",
          stream = true,
          optional = {
            max_tokens = 256,
          },
        },
      },
    })
  end,
}
