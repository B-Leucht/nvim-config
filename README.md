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

- **AI Assistance:** Claude Code TUI integration for chat-based coding assistance.
- **Snacks.nvim:** Modern all-in-one plugin providing picker, terminal, lazygit, file explorer, notifications, zen mode, and more.
- **Enhanced Git Integration:** Git interface with Snacks git features, `diffview.nvim`, and lazygit integration.
- **LaTeX & Typst Support:** Comprehensive document editing with `vimtex` for LaTeX and Typst support.
- **Terminal Management:** Seamless terminal integration with Snacks terminal (supports floating, horizontal, vertical layouts, IPython, SSH).
- **Picker:** Blazing fast fuzzy finder powered by Snacks picker for files, grep, git operations, LSP, and more.
- **Rust Development:** Enhanced Rust support with `rustaceanvim` and `crates.nvim`.
- **Java Development:** Full Java support with `nvim-jdtls`.
- **Code Execution:** Run code snippets directly with `sniprun`.
- **Markdown Rendering:** Beautiful markdown rendering with `markview.nvim` and mathematical notation with `nabla.nvim`.
- **Search & Replace:** Advanced search and replace with `grug-far`.
- **File Navigation:** Modern file explorer with `oil.nvim` and Snacks explorer.

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

### Core Plugins
- **folke/snacks.nvim:** All-in-one modern plugin (picker, terminal, notifications, lazygit, explorer, zen mode, git blame, rename, etc.)
- **echasnovski/mini.nvim:** Collection of minimal, independent Lua modules

### UI & Themes
- **catppuccin/nvim:** Beautiful Catppuccin color scheme
- **nvim-lualine/lualine.nvim:** Fast and configurable statusline
- **folke/noice.nvim:** Better UI for messages, cmdline, and popupmenu
- **folke/trouble.nvim:** Pretty diagnostics, references, and quickfix list
- **nacro90/numb.nvim:** Peek lines when entering `:number`

### Navigation and Movement
- **folke/flash.nvim:** Quick scope navigation and jumping
- **folke/which-key.nvim:** Key binding helper with visual guide
- **stevearc/oil.nvim:** File explorer that lets you edit your filesystem like a buffer

### LSP and Language Support
- **neovim/nvim-lspconfig:** Configurations for built-in LSP
- **williamboman/mason.nvim:** LSP server, formatter, and linter installer
- **WhoIsSethDaniel/mason-tool-installer.nvim:** Automatic tool installation
- **onsails/lspkind.nvim:** VSCode-like pictograms for completion

### Code Editing
- **nvim-treesitter/nvim-treesitter:** Advanced syntax highlighting and code understanding
- **nvim-cmp:** Autocompletion plugin
- **L3MON4D3/LuaSnip:** Snippet engine
- **stevearc/conform.nvim:** Formatter plugin
- **mfussenegger/nvim-lint:** Linter integration
- **folke/todo-comments.nvim:** Highlight and search TODO comments

### Debugging
- **mfussenegger/nvim-dap:** Debug Adapter Protocol client
- **rcarriga/nvim-dap-ui:** UI for nvim-dap

### Language-Specific
- **mrcjkb/rustaceanvim:** Enhanced Rust support
- **Saecki/crates.nvim:** Rust crate management
- **mfussenegger/nvim-jdtls:** Java language server integration
- **lervag/vimtex:** LaTeX support
- **MeanderingProgrammer/render-markdown.nvim:** Markdown rendering
- **chomosuke/typst-preview.nvim:** Typst document preview

### Tools
- **folke/lazydev.nvim:** Lua development for Neovim config
- **michaelb/sniprun:** Run code snippets
- **MagicDuck/grug-far.nvim:** Search and replace
- **folke/persistence.nvim:** Session management
- **sindrets/diffview.nvim:** Git diff viewer

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