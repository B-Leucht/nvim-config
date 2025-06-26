-- Native snacks terminal and lazygit keymaps
local keymap = vim.keymap.set

-- ===============================================
-- SNACKS TERMINAL - NATIVE APPROACH
-- ===============================================

-- Generate unique terminal IDs to spawn new terminals every time
local terminal_counter = 0

local function spawn_new_terminal(position_opts)
	terminal_counter = terminal_counter + 1
	local id = "terminal_" .. terminal_counter
	Snacks.terminal(nil, vim.tbl_extend("force", { id = id }, position_opts or {}))
end

-- All keymaps spawn NEW terminals with different layouts
keymap("n", "<leader>tt", function()
	-- Check if trouble is open and close it
	local trouble_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
		if ft == "trouble" then
			trouble_win = win
			break
		end
	end
	if trouble_win then
		vim.api.nvim_win_close(trouble_win, false)
	end
	
	-- Spawn new bottom terminal
	spawn_new_terminal({ win = { position = "bottom", height = 15 } })
end, { desc = "New Terminal (bottom)" })

-- Float terminal - spawns new every time
keymap("n", "<leader>tf", function()
	spawn_new_terminal({ win = { position = "float", width = 0.8, height = 0.8 } })
end, { desc = "New Terminal (float)" })

-- Bottom terminal - spawns new every time
keymap("n", "<leader>th", function()
	spawn_new_terminal({ win = { position = "bottom", height = 15 } })
end, { desc = "New Terminal (horizontal)" })

-- Right terminal - spawns new every time
keymap("n", "<leader>tv", function()
	spawn_new_terminal({ win = { position = "right", width = 80 } })
end, { desc = "New Terminal (vertical)" })

-- ===============================================
-- SNACKS LAZYGIT - NATIVE APPROACH  
-- ===============================================

-- Lazygit using snacks' built-in lazygit support
keymap("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

-- ===============================================
-- SPECIALIZED TERMINALS
-- ===============================================

-- Specialized terminals - spawn new every time
keymap("n", "<leader>py", function()
	terminal_counter = terminal_counter + 1
	Snacks.terminal("ipython", { id = "ipython_" .. terminal_counter, win = { position = "float", width = 0.8, height = 0.8 } })
end, { desc = "New IPython Terminal" })

keymap("n", "<leader>ss", function()
	terminal_counter = terminal_counter + 1
	Snacks.terminal("ssh", { id = "ssh_" .. terminal_counter, win = { position = "bottom", height = 15 } })
end, { desc = "New SSH Terminal" })

-- ===============================================
-- TERMINAL MODE KEYMAPS
-- ===============================================

-- Enhanced terminal mode navigation
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		local opts = { buffer = 0 }
		keymap("t", "<esc>", [[<C-\><C-n>]], opts)
		keymap("t", "jk", [[<C-\><C-n>]], opts)
		keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
	end,
})