# Neovim Configuration

Personal Neovim setup for Lua, Haskell, Python, Java, Rust Development and Notes
with WordNet integration and Google Translate.

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
| `<leader>T` | NeoTest                             |
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
