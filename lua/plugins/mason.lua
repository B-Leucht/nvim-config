-- Mason package manager

local gh = require("utils.gh")

-- LSP servers
local lsp_servers = {
  "basedpyright",
  "ruff",
  -- "ty",
  "bash-language-server",
  "clangd",
  "css-lsp",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "gradle-language-server",
  "gopls",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "markdown-oxide",
  "sqlls",
  "texlab",
  "tinymist",
  "tailwindcss-language-server",
  "ltex-ls-plus",
  "phpactor",
  "emmet-language-server",
  "taplo",
  "typescript-language-server",
  "yaml-language-server",
  "zls",
}

-- Debuggers (DAP)
local debuggers = {
  "codelldb",
  "java-debug-adapter",
  "java-test",
  "delve",
}

local function concat(...)
  local result = {}
  for _, t in ipairs({ ... }) do
    vim.list_extend(result, t)
  end
  return result
end

return {
  specs = {
    gh("mason-org/mason.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  },
  setup = function()
    require("mason").setup({
      ui = { border = "rounded" },
    })

    require("mason-tool-installer").setup({
      ensure_installed = concat(lsp_servers, debuggers),
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
      integrations = {
        ["mason-lspconfig"] = false,
      },
    })
  end,
}
