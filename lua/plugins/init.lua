local modules = {
  require("plugins.mini"),
  require("plugins.snacks"),
  require("plugins.flash"),
  require("plugins.which-key"),
  require("plugins.colorscheme"),
  require("plugins.statusline"),
  require("plugins.lsp-config"),
  require("plugins.mason"),
  require("plugins.cmp"),
  require("plugins.inlayhint-filler"),
  require("plugins.minuet"),
  require("plugins.treesitter"),
  require("plugins.autopairs"),
  require("plugins.dap"),
  require("plugins.dap-view"),
  require("plugins.molten"),
  require("plugins.overseer"),
  require("plugins.neogen"),
  -- require("plugins.conjure"),
  -- require("plugins.obsidian"),
  require("plugins.lang.clangd"),
  require("plugins.lang.haskell"),
  require("plugins.lang.java"),
  require("plugins.lang.rust"),
  require("plugins.lang.latex"),
  require("plugins.lang.lazydev"),
  require("plugins.lang.typst"),
  require("plugins.lang.otter"),
  require("plugins.lang.markview"),
  require("plugins.lang.web"),
  require("plugins.lang.neotest"),
  require("plugins.lang.elixir"),
}

-- Pre-load init (vim.g settings that must be set before plugins load)
for _, mod in ipairs(modules) do
  if mod.init then
    mod.init()
  end
end
-- Build hooks for post-install/update actions
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end
    if name == "nvim-treesitter" then
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    elseif name == "molten-nvim" then
      vim.schedule(function()
        if vim.fn.exists(":UpdateRemotePlugins") == 2 then
          vim.cmd("UpdateRemotePlugins")
        end
      end)
    end
  end,
})

-- Collect all specs and install/load plugins
local specs = {}
for _, mod in ipairs(modules) do
  if mod.specs then
    vim.list_extend(specs, mod.specs)
  end
end

vim.pack.add(specs)

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Update all plugins" })

-- Post-load setup
for _, mod in ipairs(modules) do
  if mod.setup then
    mod.setup()
  end
end
