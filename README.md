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
| `<leader>rr` | LSP rename |
| `<leader>rp` | LSP rename (with preview) |

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

### Terminal
| Key | Description |
|-----|-------------|
| `<leader>tt` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>py` | IPython terminal |
| `<leader>ss` | SSH terminal |

### Quickfile Operations
| Key | Description |
|-----|-------------|
| `<leader>qn` | New file |
| `<leader>qd` | Delete file |
| `<leader>qc` | Copy file |
| `<leader>qm` | Move file |
| `<leader>rn` | Rename file |

### Window Management
| Key | Description |
|-----|-------------|
| `<leader>wl` | Toggle horizontal layout |
| `<leader>wv` | Toggle vertical layout |
| `<leader>wm` | Maximize window |
| `<leader>wf` | Float current buffer |
| `<leader>ws` | Split horizontal |
| `<leader>wS` | Split vertical |

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

### Claude Code
| Key | Description |
|-----|-------------|
| `<leader>ac` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume Claude |
| `<leader>aC` | Continue Claude |
| `<leader>ab` | Add current buffer |
| `<leader>as` | Send to Claude (visual) |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

### Session (Persistence)
| Key | Description |
|-----|-------------|
| `<leader>qs` | Load session |
| `<leader>qS` | Select session |
| `<leader>ql` | Load last session |
| `<leader>qd` | Stop persistence |

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
| Key | Description |
|-----|-------------|
| `<leader>:` | Command history |
| `<leader>"` | Registers |
| `<leader>n` | Notification history |
| `<leader>ns` | Scratch buffer |
| `<leader>nS` | Select scratch buffer |
| `<leader>Z` | Zen mode |
| `<leader>ul` | Toggle line numbers |
| `<leader>ur` | Toggle relative numbers |
| `<leader>uw` | Toggle line wrap |
| `<leader>us` | Toggle spelling |
| `<leader>ud` | Toggle diagnostics |
| `<leader>ui` | Toggle indent guides |
| `<leader>un` | Toggle lualine names |
| `<leader>uC` | Colorschemes picker |

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

## Troubleshooting

If you encounter any issues:

- Ensure `lazy.nvim` is installed correctly.
- Check the logs for errors in the configuration.
- Review plugin-specific documentation for further guidance.

---