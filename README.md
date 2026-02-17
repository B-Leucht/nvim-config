# Neovim Configuration

Personal Neovim setup with lazy.nvim, snacks.nvim, and modern LSP integration.

## Features

- **Core:** lazy.nvim plugin management, snacks.nvim (picker, terminal, lazygit, explorer, notifications, zen mode), mini.nvim modules
- **AI:** Sidekick with NES suggestions, GitHub Copilot
- **LSP:** nvim-lspconfig + mason for auto-installation, blink.cmp completion
- **Languages:** Java (jdtls), LaTeX (vimtex/texpresso), Typst, Haskell, Rust, C/C++ via LSP
- **Markdown:** obsidian.nvim integration, otter.nvim for code blocks, markview.nvim rendering
- **Code Execution:** molten.nvim (Jupyter), sniprun (snippets)
- **Debug:** nvim-dap with dap-view UI (Python, C/C++, Rust)
- **Syntax:** treesitter, conform.nvim (formatting), nvim-lint (linting)
- **UI:** Catppuccin Mocha (transparent), lualine, noice.nvim, incline.nvim

## Key Bindings

Use `<leader>?` to show buffer keymaps or press any key to see which-key suggestions.

| Prefix      | Category                            |
| ----------- | ----------------------------------- |
| `<leader>f` | Find (files, buffers, projects)     |
| `<leader>s` | Search (grep, diagnostics, symbols) |
| `<leader>g` | Git (lazygit, branches, log, blame) |
| `<leader>l` | LSP (actions, rename, format)       |
| `<leader>c` | Code (format, lint)                 |
| `<leader>t` | Terminal                            |
| `<leader>d` | Debug                               |
| `<leader>o` | Obsidian                            |
| `<leader>m` | Molten (Jupyter)                    |
| `<leader>a` | AI/Sidekick                         |
| `<leader>u` | UI toggles                          |
| `s` / `S`   | Flash jump / treesitter             |

## Requirements

- Neovim >= 0.10, Nerd Font, `ripgrep`
- Python venv at `~/.venvs/neovim/` (for python3 host, molten)
- Optional: `OBSIDIAN_VAULT`, `JAVA21_HOME` env vars

## Installation

```bash
git clone https://github.com/B-Leucht/nvim-config ~/.config/nvim
nvim  # lazy.nvim installs plugins automatically
```
