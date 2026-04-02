return {
	specs = {},
	setup = function()
		vim.keymap.set("n", "<leader>gv", function()
			local file = vim.fn.expand("%")
			if file == "" then return end
			local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
			local rel = vim.fn.fnamemodify(file, ":." )
			local git_content = vim.fn.systemlist({ "git", "show", "HEAD:" .. rel })
			if vim.v.shell_error ~= 0 then
				vim.notify("File not in git or no HEAD version", vim.log.levels.WARN)
				return
			end
			vim.cmd("diffthis")
			vim.cmd("vnew")
			vim.api.nvim_buf_set_lines(0, 0, -1, false, git_content)
			vim.bo.buftype = "nofile"
			vim.bo.bufhidden = "wipe"
			vim.bo.modifiable = false
			vim.bo.filetype = vim.filetype.match({ filename = rel }) or ""
			vim.cmd("diffthis")
		end, { desc = "Diff Against HEAD" })
	end,
}
