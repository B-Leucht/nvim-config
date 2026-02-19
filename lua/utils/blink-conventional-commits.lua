local commits = {
	{ label = "feat", description = "A new feature" },
	{ label = "fix", description = "A bug fix" },
	{ label = "docs", description = "Documentation only changes" },
	{ label = "style", description = "Changes that do not affect the meaning of the code" },
	{ label = "refactor", description = "A code change that neither fixes a bug nor adds a feature" },
	{ label = "perf", description = "A code change that improves performance" },
	{ label = "test", description = "Adding missing tests or correcting existing tests" },
	{ label = "build", description = "Changes that affect the build system or external dependencies" },
	{ label = "ci", description = "Changes to CI configuration files and scripts" },
	{ label = "chore", description = "Other changes that don't modify src or test files" },
	{ label = "revert", description = "Reverts a previous commit" },
}

local items = {}
for _, c in ipairs(commits) do
	table.insert(items, {
		label = c.label,
		kind = require("blink.cmp.types").CompletionItemKind.Keyword,
		insertText = c.label,
		documentation = {
			kind = "markdown",
			value = ("**%s**\n\n%s\n\nExample: `%s: description`"):format(c.label, c.description, c.label),
		},
	})
end

local source = {}

function source.new()
	return setmetatable({}, { __index = source })
end

function source:get_completions(_, callback)
	if vim.bo.filetype ~= "gitcommit" then
		callback({ items = {} })
		return
	end

	local row = vim.api.nvim_win_get_cursor(0)[1]
	if row ~= 1 then
		callback({ items = {} })
		return
	end

	callback({ items = items })
end

return source
