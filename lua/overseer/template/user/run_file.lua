local ft_commands = {
	python = { "uv", "run", "${file}" },
	javascript = { "node", "${file}" },
	typescript = { "npx", "tsx", "${file}" },
	lua = { "lua", "${file}" },
	rust = { "cargo", "run" },
	haskell = { "cabal", "run" },
	java = { "java", "${file}" },
	c = { "sh", "-c", "gcc ${file} -o /tmp/${fileBasenameNoExtension} && /tmp/${fileBasenameNoExtension}" },
	cpp = { "sh", "-c", "g++ ${file} -o /tmp/${fileBasenameNoExtension} && /tmp/${fileBasenameNoExtension}" },
	sh = { "bash", "${file}" },
	bash = { "bash", "${file}" },
	zsh = { "zsh", "${file}" },
	go = { "go", "run", "${file}" },
}

return {
	name = "Run File",
	builder = function()
		local ft = vim.bo.filetype
		local cmd = ft_commands[ft]
		local file = vim.fn.expand("%:p")
		local stem = vim.fn.expand("%:t:r")

		local resolved = {}
		for _, arg in ipairs(cmd) do
			arg = arg:gsub("%${file}", file)
			arg = arg:gsub("%${fileBasenameNoExtension}", stem)
			table.insert(resolved, arg)
		end

		return {
			cmd = resolved,
			name = "Run: " .. vim.fn.expand("%:t"),
		}
	end,
	condition = {
		callback = function()
			return ft_commands[vim.bo.filetype] ~= nil
		end,
	},
	desc = "Run the current file with the appropriate interpreter/compiler",
}
