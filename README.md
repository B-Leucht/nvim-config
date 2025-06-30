# Neovim Configuration

Welcome to my custom Neovim configuration! This setup is designed to elevate your coding experience with carefully chosen plugins, optimized settings, and seamless integration.

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

### General Keymaps

- `<leader>ec`: Edit main configuration file.
- `<leader>ek`: Edit keymaps configuration.
- `<leader>ep`: Edit plugins configuration.
- `<leader>er`: Reload configuration.
- `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>`: Navigate windows.
- `<C-Up>`/`<C-Down>`/`<C-Left>`/`<C-Right>`: Resize windows.
- `<Tab>`/`<S-Tab>`: Navigate buffers using BufferLine.
- `<leader>bd`: Delete buffer (keep window).
- `<leader>bD`: Force delete buffer.
- `<leader>bc`: Close other buffers.
- `<leader>bl`: Close buffers to left.
- `<leader>br`: Close buffers to right.
- `<leader>bp`: Pick buffer.
- `<leader>h`: Clear highlights.
- `<leader>w`: Quick save.
- `<leader>q`: Quick quit.
- `<leader>Q`: Force quit.
- `<leader>x`: Save and quit.
- `<leader>o`: New line above without entering insert mode.
- `<leader>O`: New line below without entering insert mode.
- `<leader>y`: Yank to system clipboard.
- `<leader>P`: Paste from system clipboard.

### LSP Keymaps

- `K`: Show hover documentation (Lspsaga).
- `gh`: Find LSP references (Lspsaga).
- `<leader>ca`: Apply code actions (Lspsaga).
- `gr`: Rename symbols (Lspsaga).
- `[e` & `]e`: Jump to previous/next diagnostic (Lspsaga).
- `<leader>f`: Format the code.
- `gD`: Go to declaration.
- `gd`: Go to definition.
- `gi`: Go to implementation.
- `gt`: Go to type definition.
- `<leader>gd`: Peek definition (Lspsaga).
- `<leader>gt`: Peek type definition (Lspsaga).
- `<leader>o`: Toggle outline (Lspsaga).
- `<leader>d`: Show line diagnostics.
- `[d` & `]d`: Jump to previous/next diagnostic.

### Terminal Key maps

- `<esc>`: Toggle terminal mode.
- `<C-h/j/k/l>`: Navigate terminal windows.
- `jk`: Exit terminal mode.
- `<leader>tt`: Toggle Terminal.
- `<leader>tf`: Open terminal in float mode.
- `<leader>th`: Open terminal in horizontal split.
- `<leader>tv`: Open terminal in vertical split.
- `<leader>tc`: Toggle Claude (float).
- `<leader>tC`: Toggle Claude (horizontal).
- `<leader>tcv`: Toggle Claude (vertical).

### Dial Keymaps

- `<C-a>`: Increment.
- `<C-x>`: Decrement.
- `g<C-a>`/`g<C-x>`: Visual increment/decrement.

### FZF-Lua Keymaps

- `<leader>ff`: Find files.
- `<leader>fg`: Live grep.
- `<leader>fb`: Show buffers.
- `<leader>fh`: Help tags.
- `<leader>fr`: Old files.
- `<leader>fc`: Find commands.
- `<leader>fk`: Show keymaps.
- `<leader>fs`: Search current word.
- `<leader>fS`: Search current WORD.
- `<leader>ft`: Find TODOs.
- `<leader>ls`: Document symbols.
- `<leader>lS`: Workspace symbols.
- `<leader>lr`: LSP references.
- `<leader>ld`: LSP definitions.
- `<leader>li`: LSP implementations.

### Git Keymaps

- `<leader>gg`: Open Neogit.
- `<leader>gc`: Neogit commit.
- `<leader>gp`: Neogit push.
- `<leader>gl`: Neogit pull.
- `<leader>gb`: Git branches (FZF).
- `<leader>gs`: Git status (FZF).
- `<leader>ghs`: Stage hunk.
- `<leader>ghr`: Reset hunk.
- `<leader>ghS`: Stage buffer.
- `<leader>ghu`: Undo stage hunk.
- `<leader>ghR`: Reset buffer.
- `<leader>ghp`: Preview hunk.
- `<leader>ghb`: Blame line.
- `<leader>gtb`: Toggle current line blame.
- `<leader>ghd`: Diff this.
- `<leader>gdo`: Open Diffview.
- `<leader>gdc`: Close Diffview.
- `<leader>gdh`: Diffview file history.

### Oil Keymaps

- `-`: Open parent directory.
- `<leader>E`: Open Oil in floating window.
- `<leader>Er`: Open remote directory in Oil.

### Flash Keymaps

- `s`: Flash jump.
- `S`: Flash treesitter.
- `r`: Remote flash (operator mode).
- `R`: Treesitter search.
- `<c-s>`: Toggle flash search.

### Todo Comments Keymaps

- `[t`: Jump to previous TODO comment.
- `]t`: Jump to next TODO comment.
- `<leader>ft`: Find TODOs.

### VimTeX Keymaps

- `<leader>vtl`: Compile document.
- `<leader>vtv`: View compiled output.
- `<leader>vts`: Stop compilation.
- `<leader>vtc`: Clean auxiliary files.
- `<leader>vtC`: Clean all files.
- `<leader>vte`: Show errors.
- `<leader>vto`: Show compilation output.
- `<leader>vtg`: Show status.
- `<leader>vtG`: Show status for all.
- `<leader>vtt`: Toggle table of contents.

### AI Assistance Keymaps

- `<C-J>`: Accept Copilot suggestion.
- `<leader>cp`: Toggle Copilot.
- `<leader>ac`: Toggle Claude Code.
- `<leader>af`: Focus Claude Code.
- `<leader>ar`: Resume Claude Code.
- `<leader>aC`: Continue Claude Code.
- `<leader>ab`: Add current buffer to Claude.
- `<leader>as`: Send to Claude (visual mode).
- `<leader>aa`: Accept Claude diff.
- `<leader>ad`: Deny Claude diff.

### Additional Keymaps

- `<leader>r`: Run code snippet (Sniprun).
- `<leader>rc`: Close Sniprun.
- `<leader>rt`: Terminate Sniprun.
- `<leader>sr`: Toggle Spectre (Search & Replace).
- `<leader>sw`: Search current word.
- `<leader>sf`: Search in current file.
- `<leader>co`: Open compiler.
- `<leader>cr`: Redo compilation.
- `<leader>ct`: Toggle compilation results.
- `<leader>cs`: Stop compilation.
- `<leader>p`: Toggle Nabla/MarkView preview.
- `<leader>xx`: Toggle Trouble diagnostics.
- `<leader>xX`: Buffer diagnostics (Trouble).
- `<leader>cl`: LSP definitions/references (Trouble).
- `<leader>?`: Show which-key help.

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

### Syntax Highlighting and Parsing

- **nvim-treesitter/nvim-treesitter:** Advanced syntax highlighting and parsing.
- **RRethy/vim-illuminate:** Highlight word under cursor throughout buffer.
- **folke/todo-comments.nvim:** Highlight and manage TODO comments.

### Autocompletion and Snippets

- **hrsh7th/nvim-cmp:** Powerful completion framework.
- **hrsh7th/cmp-nvim-lsp:** LSP completion source.
- **hrsh7th/cmp-buffer:** Buffer completion source.
- **hrsh7th/cmp-path:** Path completion source.
- **hrsh7th/cmp-cmdline:** Command line completion.
- **hrsh7th/cmp-nvim-lua:** Lua completion for Neovim config.
- **hrsh7th/cmp-nvim-lsp-signature-help:** Function signature help.
- **lukas-reineke/cmp-rg:** Ripgrep completion source.
- **SergioRibera/cmp-dotenv:** Environment variable completion.
- **davidsierradz/cmp-conventionalcommits:** Conventional commit completion.
- **petertriho/cmp-git:** Git completion source.
- **L3MON4D3/LuaSnip:** Powerful snippet engine.
- **rafamadriz/friendly-snippets:** Collection of useful snippets.
- **iurimateus/luasnip-latex-snippets.nvim:** LaTeX snippets for LuaSnip.

### Code Editing and Utilities

- **numToStr/Comment.nvim:** Smart commenting functionality.
- **michaelb/sniprun:** Run code snippets directly in Neovim.
- **nvim-pack/nvim-spectre:** Advanced search and replace.
- **kylechui/nvim-surround:** Surround text objects with ease.
- **windwp/nvim-autopairs:** Automatic bracket and quote pairing.
- **kevinhwang91/nvim-hlslens:** Enhanced search highlighting.
- **nacro90/numb.nvim:** Peek line numbers while using :goto.

### Build and Compilation

- **Zeioth/compiler.nvim:** Compile and run code with ease.
- **stevearc/overseer.nvim:** Task runner and job management.

### Code Formatting and Linting

- **stevearc/conform.nvim:** Lightweight formatter with support for multiple tools.
- **mfussenegger/nvim-lint:** Asynchronous linting framework.

### File Management and Search

- **stevearc/oil.nvim:** Edit your filesystem like a buffer.
- **refractalize/oil-git-status.nvim:** Git status integration for Oil.
- **JezerM/oil-lsp-diagnostics.nvim:** LSP diagnostics in Oil.
- **nvim-tree/nvim-web-devicons:** File type icons.
- **ibhagwan/fzf-lua:** Blazing fast fuzzy finder using FZF.
- **nvim-telescope/telescope.nvim:** Extensible fuzzy finder (used by compiler.nvim).

### Git Integration

- **NeogitOrg/neogit:** Modern Git interface inspired by Magit.
- **lewis6991/gitsigns.nvim:** Git signs and hunks in the gutter.
- **sindrets/diffview.nvim:** Tabpage interface for cycling through diffs.

### UI Enhancements

- **goolord/alpha-nvim:** Customizable greeter/start screen.
- **lukas-reineke/indent-blankline.nvim:** Indentation guides.
- **akinsho/toggleterm.nvim:** Terminal management and integration.
- **folke/noice.nvim:** Enhanced UI for messages, cmdline, and popupmenu.
- **rcarriga/nvim-notify:** Beautiful notification system.
- **nvim-lualine/lualine.nvim:** Fast and customizable statusline.
- **akinsho/bufferline.nvim:** Snazzy buffer line with tabpage integration.
- **famiu/bufdelete.nvim:** Delete buffers without messing up window layout.
- **folke/trouble.nvim:** Diagnostics, references, and more in a pretty list.

### AI Assistance

- **zbirenbaum/copilot.lua:** GitHub Copilot integration.
- **zbirenbaum/copilot-cmp:** Copilot completion source for nvim-cmp.
- **coder/claudecode.nvim:** Claude Code TUI integration.

### Language-Specific Support

#### Rust

- **mrcjkb/rustaceanvim:** Supercharge your Rust experience.
- **saecki/crates.nvim:** Crates.io dependency management.

#### LaTeX

- **lervag/vimtex:** Comprehensive LaTeX support.

### Markdown and Documentation

- **OXY2DEV/markview.nvim:** Beautiful markdown rendering.
- **jbyuki/nabla.nvim:** Mathematical notation rendering.

---

## Installation

1. Clone this repository into your Neovim configuration directory:

   ```bash
   git clone https://github.com/your/repo ~/.config/nvim
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
