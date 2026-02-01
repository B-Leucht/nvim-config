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
- **Smart Dashboard:** Custom dashboard with project shortcuts, git status, and Obsidian task integration (when in vault directory).

### Unique Features

- **AI Assistance:** Multiple AI integrations including OpenCode, Sidekick, and GitHub Copilot for chat-based coding assistance.
- **Snacks.nvim:** Modern all-in-one plugin providing picker, terminal, lazygit, file explorer, notifications, zen mode, image rendering (including LaTeX math), and more.
- **Enhanced Git Integration:** Git interface with Snacks git features, `diffview.nvim`, lazygit integration, and GitHub issue picker.
- **LaTeX & Typst Support:** Comprehensive document editing with `vimtex` for LaTeX and Typst support with inline math rendering.
- **Terminal Management:** Seamless terminal integration with Snacks terminal (supports floating, horizontal, vertical layouts, IPython, SSH).
- **Picker:** Blazing fast fuzzy finder powered by Snacks picker for files, grep, git operations, LSP, and more.
- **Rust Development:** Enhanced Rust support with `rustaceanvim` and `crates.nvim`.
- **Java Development:** Full Java support with `nvim-jdtls`.
- **C/C++ Development:** Configured with clangd and debugging support.
- **Code Execution:** Multiple execution backends - `sniprun` for snippets, `molten.nvim` for Jupyter-like notebook experience with image support.
- **Markdown Support:** Enhanced markdown with `obsidian.nvim`, `otter.nvim` for LSP in code blocks, and LaTeX math rendering.
- **Obsidian Integration:** Full Obsidian vault integration with daily notes, templates, backlinks, and task tracking on dashboard.
- **File Navigation:** Modern file explorer with `oil.nvim` (including extras) and Snacks explorer.
- **Task Runner:** Task automation with `overseer.nvim`.

---

## Keymaps

### General

| Key | Description |
|-----|-------------|
| `<C-h/j/k/l>` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows |
| `<Tab>` / `<S-Tab>` | Next/previous buffer |
| `<leader>b1-9` | Jump to buffer by index |
| `<leader>bd` | Delete buffer (keep window) |
| `<leader>bD` | Force delete buffer |
| `<leader>h` | Clear search highlights |
| `<leader>w` | Quick save |
| `<leader>q` | Quick quit |
| `<leader>Q` | Force quit |
| `<leader>x` | Save and quit |
| `<leader>o/O` | New line below/above without insert mode |
| `<leader>y` | Yank to system clipboard |
| `<leader>P` | Paste from system clipboard |
| `<leader>?` | Show buffer local keymaps |

### Visual Mode

| Key | Description |
|-----|-------------|
| `<` / `>` | Indent left/right (stay in visual mode) |
| `J` / `K` | Move selection down/up |
| `<A-j>` / `<A-k>` | Move selection down/up |

### File Navigation & Picker

| Key | Description |
|-----|-------------|
| `<leader><space>` | Smart find files |
| `<leader>e` | Toggle file explorer |
| `<leader>fb` | Find buffers |
| `<leader>fc` | Find config files |
| `<leader>ff` | Find files |
| `<leader>fg` | Find git files |
| `<leader>fo` | Open oil (parent directory) |
| `<leader>fO` | Open oil (cwd) |
| `<leader>fp` | Find projects |
| `<leader>fr` | Recent files |
| `<leader>fz` | Zoxide |
| `<leader>fn` | Find notifications |

### Search & Grep

| Key | Description |
|-----|-------------|
| `<leader>sb` | Search buffer lines |
| `<leader>sB` | Grep open buffers |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep word under cursor |
| `<leader>sr` | Search and replace |
| `<leader>sR` | Search and replace (current file) |
| `<leader>s/` | Search history |
| `<leader>sa` | Search autocmds |
| `<leader>sc` | Command history |
| `<leader>sC` | Commands |
| `<leader>sd` | Diagnostics |
| `<leader>sD` | Buffer diagnostics |
| `<leader>sh` | Help pages |
| `<leader>sH` | Highlights |
| `<leader>si` | Icons |
| `<leader>sj` | Jumps |
| `<leader>sk` | Keymaps |
| `<leader>sl` | Location list |
| `<leader>sm` | Marks |
| `<leader>sM` | Man pages |
| `<leader>sp` | Plugin specs |
| `<leader>sq` | Quickfix list |
| `<leader>sR` | Resume last picker |
| `<leader>ss` | LSP symbols |
| `<leader>sS` | LSP workspace symbols |
| `<leader>st` | Todo comments |
| `<leader>sT` | Todo/Fix/Fixme comments |
| `<leader>su` | Undo history |

### LSP

| Key | Description |
|-----|-------------|
| `gd` | Goto definition |
| `gD` | Goto declaration |
| `gr` | Find references |
| `gI` | Goto implementation |
| `gy` | Goto type definition |
| `<leader>la` | Code actions |
| `<leader>lr` | LSP rename |
| `<leader>lp` | LSP rename (with preview) |

### Git

| Key | Description |
|-----|-------------|
| `<leader>gg` | Toggle lazygit |
| `<leader>gb` | Git branches |
| `<leader>gbl` | Git blame line |
| `<leader>gbf` | Git blame file |
| `<leader>gd` | Git diff (hunks) |
| `<leader>gf` | Git log file |
| `<leader>gfl` | Git log for file |
| `<leader>gl` | Git log |
| `<leader>gL` | Git log line |
| `<leader>go` | Open in browser |
| `<leader>gO` | Open file in git web |
| `<leader>gR` | Browse git repository |
| `<leader>gs` | Git status |
| `<leader>gS` | Git stash |
| `<leader>gi` | GitHub issues |
| `<leader>gdo` | Diffview open |
| `<leader>gdc` | Diffview close |
| `<leader>gdh` | Diffview file history |

### Terminal

| Key | Description |
|-----|-------------|
| `<leader>tt` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>py` | IPython terminal |
| `<leader>ss` | SSH terminal |

### Window Management

| Key | Description |
|-----|-------------|
| `<leader>wm` | Maximize window |
| `<leader>wf` | Float current buffer |
| `<leader>ws` | Split horizontal |
| `<leader>wS` | Split vertical |

### File Operations

| Key | Description |
|-----|-------------|
| `<leader>rn` | Rename file |

### Debug (DAP)

| Key | Description |
|-----|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dt` | Terminate |

### Diagnostics (Trouble)

| Key | Description |
|-----|-------------|
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics (Trouble) |
| `<leader>xs` | Symbols (Trouble) |
| `<leader>cl` | LSP definitions/references (Trouble) |
| `<leader>xL` | Location list (Trouble) |
| `<leader>xQ` | Quickfix list (Trouble) |

### Todo Comments

| Key | Description |
|-----|-------------|
| `]t` | Next todo comment |
| `[t` | Previous todo comment |

### Flash (Navigation)

| Key | Description |
|-----|-------------|
| `s` | Flash jump |
| `S` | Flash treesitter |
| `r` | Remote flash (operator mode) |
| `R` | Treesitter search (operator/visual) |
| `<C-s>` | Toggle flash search (command mode) |

### Oil (File Explorer)

| Key | Description |
|-----|-------------|
| `-` | Open parent directory (float) |
| `q` | Close oil buffer |
| `<C-p>` | Preview file |
| `<C-c>` | Close oil |

### LaTeX (VimTeX)

| Key | Description |
|-----|-------------|
| `<leader>vtl` | Compile |
| `<leader>vtv` | View PDF |
| `<leader>vts` | Stop compilation |
| `<leader>vtc` | Clean auxiliary files |
| `<leader>vtC` | Clean all files |
| `<leader>vte` | Show errors |
| `<leader>vto` | Show compilation output |
| `<leader>vtg` | Status |
| `<leader>vtG` | Status (all) |
| `<leader>vtt` | Toggle TOC |

### Markdown

| Key | Description |
|-----|-------------|
| `<leader>p` | Toggle Nabla/RenderMarkdown preview |

Note: Markdown files automatically activate `otter.nvim` for LSP features in embedded code blocks.

### AI Assistants

#### OpenCode
| Key | Description |
|-----|-------------|
| `<leader>ac` | Toggle OpenCode |
| `<leader>af` | Focus OpenCode |
| `<leader>ar` | Resume/Ask OpenCode |
| `<leader>aC` | Continue OpenCode |
| `<leader>ab` | Add current buffer |
| `<leader>as` | Send to OpenCode (visual) |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |
| `<C-a>` | Ask OpenCode... |
| `<C-x>` | Execute OpenCode action... |
| `<C-.>` | Toggle OpenCode |
| `go` | Add range to OpenCode (operator) |
| `goo` | Add line to OpenCode |
| `<S-C-u>` | Scroll OpenCode up |
| `<S-C-d>` | Scroll OpenCode down |

#### Sidekick
| Key | Description |
|-----|-------------|
| `<C-.>` | Toggle Sidekick |
| `<leader>aa` | Toggle Sidekick CLI |
| `<leader>as` | Select CLI |
| `<leader>ad` | Detach CLI session |
| `<leader>at` | Send this (visual/normal) |
| `<leader>af` | Send file |
| `<leader>av` | Send visual selection |
| `<leader>ap` | Sidekick select prompt |

### Obsidian

| Key | Description |
|-----|-------------|
| `<leader>od` | Daily note |
| `<leader>oy` | Yesterday |
| `<leader>oT` | Tomorrow |
| `<leader>on` | New note |
| `<leader>oN` | New from template |
| `<leader>os` | Search notes |
| `<leader>oq` | Quick switch |
| `<leader>ob` | Backlinks |
| `<leader>ot` | Tags |
| `<leader>ol` | Links |
| `<leader>oc` | Table of contents |
| `<leader>or` | Rename note |
| `<leader>oi` | Paste image |
| `<leader>oo` | Open in Obsidian app |
| `<leader>oO` | Open tasks |
| `<leader>om` | Move note |

### Molten (Jupyter)

| Key | Description |
|-----|-------------|
| `<leader>mi` | Initialize Molten |
| `<leader>me` | Evaluate operator |
| `<leader>ml` | Evaluate line |
| `<leader>mr` | Re-evaluate cell |
| `<leader>md` | Delete cell |
| `<leader>mo` | Show output |
| `<leader>mh` | Hide output |
| `<leader>mx` | Interrupt kernel |
| `<leader>mc` | Enter output window |
| `<leader>mb` | Evaluate code block |
| `<leader>r` | Evaluate selection (visual) |

### Overseer (Tasks)

| Key | Description |
|-----|-------------|
| `<leader>Oo` | Toggle Overseer |
| `<leader>Or` | Run task |
| `<leader>Ob` | Build |
| `<leader>Oa` | Task action |
| `<leader>Oq` | Quick action |
| `<leader>Ol` | Restart last task |

### Diffview

| Key | Description |
|-----|-------------|
| `<leader>gdo` | Diffview open |
| `<leader>gdc` | Diffview close |
| `<leader>gdh` | Diffview file history |

### Sniprun

| Key | Description |
|-----|-------------|
| `<leader>r` | Run code snippet |
| `<leader>rc` | Close sniprun |
| `<leader>rt` | Terminate sniprun |

### Utilities

| Key          | Description             |
| ------------ | ----------------------- |
| `<leader>:`  | Command history         |
| `<leader>"`  | Registers               |
| `<leader>n`  | Notification history    |
| `<leader>ns` | Scratch buffer          |
| `<leader>nS` | Select scratch buffer   |
| `<leader>Z`  | Zen mode                |
| `<leader>ul` | Toggle line lualine     |
| `<leader>ur` | Toggle relative numbers |
| `<leader>uw` | Toggle line wrap        |
| `<leader>us` | Toggle spelling         |
| `<leader>ud` | Toggle diagnostics      |
| `<leader>ui` | Toggle indent guides    |
| `<leader>un` | Toggle lualine names    |
| `<leader>uC` | Colorschemes picker     |

Note: When on the dashboard in an Obsidian vault, press `t` to open task picker.

---

## Plugins

### Core Plugins

- **folke/snacks.nvim:** All-in-one modern plugin (picker, terminal, notifications, lazygit, explorer, zen mode, git blame, rename, image rendering, etc.)
- **echasnovski/mini.nvim:** Collection of minimal, independent Lua modules

### AI & Coding Assistants

- **NickvanDyke/opencode.nvim:** AI-powered code assistant integration
- **folke/sidekick.nvim:** Advanced AI assistant with NES (edit suggestions) and CLI support
- **zbirenbaum/copilot.lua:** GitHub Copilot integration

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
- **chomosuke/typst-preview.nvim:** Typst document preview
- **jmbuhr/otter.nvim:** LSP features for embedded code blocks in markdown

### Markdown & Note-Taking

- **obsidian-nvim/obsidian.nvim:** Full Obsidian vault integration with Snacks picker support
- **benlubas/molten-nvim:** Jupyter-like notebook experience with inline image rendering

### Tools

- **folke/lazydev.nvim:** Lua development for Neovim config
- **michaelb/sniprun:** Run code snippets
- **stevearc/overseer.nvim:** Task runner and build automation
- **sindrets/diffview.nvim:** Git diff viewer
- **stevearc/oil.nvim:** File explorer that lets you edit your filesystem like a buffer

---

## Installation

1. Clone this repository into your Neovim configuration directory:

   ```bash
   git clone https://github.com/B-Leucht/nvim-config ~/.config/nvim
   ```

2. Open Neovim and let the `lazy.nvim` plugin manager install everything.

---

## Troubleshooting

If you encounter any issues:

- Ensure `lazy.nvim` is installed correctly.
- Check the logs for errors in the configuration.
- Review plugin-specific documentation for further guidance.

---
