# Neovim Configuration

Welcome to my custom Neovim configuration! This setup is designed to elevate your coding experience with carefully chosen plugins, optimized settings, and seamless integration.

---

## Table of Contents
- [Features](#features)
- [Keymaps](#keymaps)
- [Plugins](#plugins)
- [Installation](#installation)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)

---

## Features

### General Setup

- **Plugin Management:** Uses `lazy.nvim` for managing plugins.
- **VS Code Detection:** Automatically loads lightweight configurations for Neovim in VS Code.
- **Keymaps:** Intuitive shortcuts for efficient navigation and editing.
- **Core Configuration:** Predefined options for a smooth and productive development environment.

### Unique Features

- **AI Assistance:** Includes Copilot and Claude Code TUI integration for code suggestions and chat-based coding assistance.
- **Enhanced Git Integration:** Modern Git interface with `neogit`, `gitsigns.nvim`, and `diffview.nvim`.
- **LaTeX Support:** Comprehensive LaTeX editing with `vimtex` and `luasnip-latex-snippets.nvim`.
- **Terminal Management:** Seamless terminal integration with `toggleterm.nvim`.
- **Fuzzy Finder:** Blazing fast file and text search with `fzf-lua`.
- **Rust Development:** Enhanced Rust support with `rustaceanvim` and `crates.nvim`.
- **Code Execution:** Run code snippets directly with `sniprun`.
- **Markdown Rendering:** Beautiful markdown rendering with `markview.nvim` and mathematical notation with `nabla.nvim`.

---

## Keymaps

Keymaps have been summarized into an easy-to-read table format for better navigation:

| Key Combination           | Description                                    |
|---------------------------|------------------------------------------------|
| `<leader>ec`              | Edit main configuration file                  |
| `<leader>ek`              | Edit keymaps configuration                    |
| `<leader>ep`              | Edit plugins configuration                    |
| `<leader>er`              | Reload configuration                          |
| `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>` | Navigate windows                             |
| `<C-Up>`/`<C-Down>`/`<C-Left>`/`<C-Right>` | Resize windows                   |
| `<Tab>`/`<S-Tab>`         | Navigate buffers using BufferLine             |
| `<leader>bd`              | Delete buffer (keep window)                   |
| `<leader>bD`              | Force delete buffer                           |
| `<leader>bc`              | Close other buffers                           |
| `<leader>bl`              | Close buffers to left                         |
| `<leader>br`              | Close buffers to right                        |
| `<leader>bp`              | Pick buffer                                   |
| `<leader>h`               | Clear highlights                              |
| `<leader>w`               | Quick save                                    |
| `<leader>q`               | Quick quit                                    |
| `<leader>Q`               | Force quit                                    |
| `<leader>x`               | Save and quit                                 |
| `<leader>o`               | New line above without entering insert mode   |
| `<leader>O`               | New line below without entering insert mode   |
| `<leader>y`               | Yank to system clipboard                      |
| `<leader>P`               | Paste from system clipboard                   |

For a full list of keymaps, refer to the detailed sections in the README.

---

## Plugins

### Themes
- **catppuccin/nvim:** Beautiful Catppuccin color scheme.

### Navigation and Movement
- **folke/flash.nvim:** Quick scope navigation and jumping.
- **monaqa/dial.nvim:** Advanced manipulation of numbers and dates.
- **karb94/neoscroll.nvim:** Smooth scrolling animations.
- **folke/which-key.nvim:** Key binding helper with visual guide.

### LSP and Language Support
- **neovim/nvim-lspconfig:** Configurations for built-in LSP.
- **williamboman/mason.nvim:** LSP server, formatter, and linter installer.
- **williamboman/mason-lspconfig.nvim:** Mason integration for LSP.
- **WhoIsSethDaniel/mason-tool-installer.nvim:** Automatic tool installation.
- **nvimdev/lspsaga.nvim:** Enhanced LSP UI with beautiful interface.
- **onsails/lspkind.nvim:** VSCode-like pictograms for completion.

(Refer to the full README for a complete plugin list.)

---

## Installation

1. Clone this repository into your Neovim configuration directory:

   ```bash
   git clone https://github.com/B-Leucht/nvim-config ~/.config/nvim
   ```

2. Open Neovim and let the `lazy.nvim` plugin manager install everything.

---

## Usage

### Keymaps

Navigate using the intuitive shortcuts listed above.

---

### Troubleshooting

If you encounter any issues:

- Ensure `lazy.nvim` is installed correctly.
- Check the logs for errors in the configuration.
- Review plugin-specific documentation for further guidance.

---