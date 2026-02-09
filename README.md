# Neovim Configuration

Personal Neovim setup with lazy.nvim, snacks.nvim, and modern LSP integration.

## Features

- **Core:** lazy.nvim plugin management, snacks.nvim (picker, terminal, lazygit, explorer, notifications, zen mode), mini.nvim modules
- **AI:** Sidekick with NES suggestions, GitHub Copilot
- **LSP:** nvim-lspconfig + mason for auto-installation, blink.cmp completion
- **Languages:** Java (jdtls), LaTeX (vimtex), Typst, Rust/C++ via LSP
- **Markdown:** obsidian.nvim integration, otter.nvim for code blocks, markview.nvim rendering
- **Code Execution:** molten.nvim (Jupyter), sniprun (snippets)
- **Debug:** nvim-dap with dap-view UI
- **UI:** Catppuccin theme, lualine, noice.nvim, incline.nvim

## Key Bindings

Use `<leader>?` to show buffer keymaps or press any key to see which-key suggestions.

| Prefix      | Category                            |
| ----------- | ----------------------------------- |
| `<leader>f` | Find (files, buffers, projects)     |
| `<leader>s` | Search (grep, diagnostics, symbols) |
| `<leader>g` | Git (lazygit, branches, log, blame) |
| `<leader>l` | LSP (actions, rename)               |
| `<leader>t` | Terminal                            |
| `<leader>d` | Debug                               |
| `<leader>o` | Obsidian                            |
| `<leader>m` | Molten (Jupyter)                    |
| `<leader>a` | AI/Sidekick                         |
| `<leader>u` | UI toggles                          |
| `s` / `S`   | Flash jump / treesitter             |

## Installation

```bash
git clone https://github.com/B-Leucht/nvim-config ~/.config/nvim
nvim  # lazy.nvim installs plugins automatically
```
