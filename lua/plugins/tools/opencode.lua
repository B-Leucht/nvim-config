-- Opencode integration
return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		-- Recommended for `ask()` and `select()`.
		-- Required for `snacks` provider.
		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	config = function()
		vim.g.opencode_opts = {
			provider = {
				enabled = "snacks",
				snacks = {
					window = {
						width = require("core.constants").UI.SIDEBAR_WIDTH / 100,
					},
				}
			}
		}

		-- Required for `opts.events.reload`.
		vim.o.autoread = true

		-- Claudecode-style keymaps
		vim.keymap.set("n", "<leader>ac", function()
			require("opencode").toggle()
		end, { desc = "Toggle Opencode" })
		vim.keymap.set("n", "<leader>af", function()
			require("opencode").toggle()
		end, { desc = "Focus Opencode" })
		vim.keymap.set("n", "<leader>ar", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Resume/Ask Opencode" })
		vim.keymap.set("n", "<leader>aC", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Continue Opencode" })
		vim.keymap.set("n", "<leader>ab", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Add current buffer" })
		vim.keymap.set("v", "<leader>as", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Send to Opencode" })
		vim.keymap.set("n", "<leader>aa", function()
			require("opencode").command("diff.accept")
		end, { desc = "Accept diff" })
		vim.keymap.set("n", "<leader>ad", function()
			require("opencode").command("diff.deny")
		end, { desc = "Deny diff" })

		-- Additional opencode-specific keymaps
		vim.keymap.set({ "n", "x" }, "<C-a>", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set({ "n", "x" }, "<C-x>", function()
			require("opencode").select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "t" }, "<C-.>", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })

		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this ")
		end, { desc = "Add range to opencode", expr = true })
		vim.keymap.set("n", "goo", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Add line to opencode", expr = true })

		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll opencode up" })
		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll opencode down" })

		-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
	end,
}

