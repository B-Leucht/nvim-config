-- Mason package manager

local gh = function(x) return "https://github.com/" .. x end

-- LSP servers
local lsp_servers = {
	"basedpyright",
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
	-- "lua-language-server",
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

-- Formatters
local formatters = {
	"stylua",
	"google-java-format",
	"jq",
	"clang-format",
	"fourmolu",
	"prettier",
	"latexindent",
	"bibtex-tidy",
	-- "mdsf",       -- not in mason registry
	"sql-formatter",
	"goimports",
	"gofumpt",
}

-- Linters
local linters = {
	"ruff",
	"shellcheck",
	"luacheck",
	"markdownlint",
	"yamllint",
	"checkstyle",
	"hlint",
	"cpplint",
	"vale",
	"sqlfluff",
	"alex",
	"golangci-lint",
}

-- Debuggers (DAP)
local debuggers = {
	"codelldb",
	"java-debug-adapter",
	"java-test",
	"delve",
}

-- vim.lsp names for vim.lsp.enable() (excludes manually managed: hls, jdtls, rust_analyzer)
local lsp_enable = {
	"basedpyright",
	"bashls",
	"clangd",
	"cssls",
	"docker_compose_language_service",
	"dockerls",
	"gradle_ls",
	"gopls",
	"html",
	"jsonls",
	-- "lua_ls",
	"markdown_oxide",
	"sqlls",
	"texlab",
	"tinymist",
	"tailwindcss",
	"ltex_plus",
	"phpactor",
	"emmet_language_server",
	"taplo",
	"ts_ls",
	"yamlls",
	"zls",
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
			ensure_installed = concat(lsp_servers, formatters, linters, debuggers),
			run_on_start = true,
			start_delay = 3000,
			debounce_hours = 5,
			integrations = {
				["mason-lspconfig"] = false,
			},
		})

		vim.lsp.enable(lsp_enable)
	end,
}
