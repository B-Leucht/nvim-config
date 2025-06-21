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
- **AI Assistance:** Includes Copilot and Avante AI for code suggestions and chat-based coding assistance.
- **Enhanced Git Integration:** Tools like `vim-fugitive`, `gitsigns.nvim`, and `diffview.nvim`.
- **Latex Support:** Comprehensive Latex editing with `vimtex` and `luasnip-latex-snippets.nvim`.
- **Terminal Management:** Seamless terminal integration with `toggleterm.nvim`.
- **Fuzzy Finder:** Blazing fast file and text search with `fzf-lua`.

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
- `K`: Show hover documentation.
- `gh`: Find LSP references.
- `<leader>ca`: Apply code actions.
- `gr`: Rename symbols.
- `[e` & `]e`: Jump to previous/next diagnostic.
- `<leader>f`: Format the code.

### Terminal Keymaps
- `<esc>`: Toggle terminal mode.
- `<C-h/j/k/l>`: Navigate terminal windows.
- `jk`: Exit terminal mode.
- `<leader>tt`: Toggle Terminal.
- `<leader>tf`: Open terminal in float mode.
- `<leader>th`: Open terminal in horizontal split.
- `<leader>tv`: Open terminal in vertical split.

### Dial Keymaps
- `<C-a>`: Increment.
- `<C-x>`: Decrement.
- `g<C-a>`/`g<C-x>`: Visual increment/decrement.

### Fzf Keymaps
- `<leader>ff`: Find files.
- `<leader>fg`: Live grep.
- `<leader>fb`: Show buffers.
- `<leader>fh`: Help tags.
- `<leader>fr`: Resume search.
- `<leader>fc`: Select colorscheme.
- `<leader>fk`: Show keymaps.
- `<leader>fs`: Search current word.
- `<leader>fS`: Search current WORD.

### Git Keymaps
- `<leader>gb`: Git branches.
- `<leader>gc`: Git commits.
- `<leader>gs`: Git status.

### Oil Keymaps
- `-`: Open parent directory.
- `<CR>`: Select file or directory.
- `<C-s>`: Open in vertical split.
- `<C-h>`: Open in horizontal split.
- `<C-t>`: Open in new tab.
- `<C-p>`: Preview file.

### Flash Keymaps
- `s`: Flash jump.
- `S`: Flash treesitter.
- `R`: Treesitter search.
- `<c-s>`: Toggle flash search.

### Todo Comments Keymaps
- `[t`: Jump to previous TODO comment.
- `]t`: Jump to next TODO comment.
- `<leader>ft`: Find TODOs.

### Vimtex Keymaps
- `<leader>ll`: Compile document.
- `<leader>lv`: View compiled output.
- `<leader>lt`: Toggle table of contents.

### Copilot Keymaps
- `<C-J>`: Accept Copilot suggestion.

---

## Plugins

### Themes
- **catppuccin/nvim:** Beautiful color scheme.

### Navigation and Movement
- **folke/flash.nvim:** Quick scope navigation.
- **monaqa/dial.nvim:** Advanced manipulation of numbers and dates.
- **nanotee/zoxide.vim:** Zoxide integration for faster directory navigation.

### LSP and Language Support
- **neovim/nvim-lspconfig:** Configurations for built-in LSP.
- **williamboman/mason.nvim:** Automates LSP server installation and updates.
- **williamboman/mason-lspconfig.nvim:** Extends Mason for LSP.
- **nvimdev/lspsaga.nvim:** UI improvements for LSP functionalities.
- **onsails/lspkind.nvim:** Adds icons to completion items.

### Syntax Highlighting
- **nvim-treesitter/nvim-treesitter:** Advanced syntax highlighting.
- **folke/todo-comments.nvim:** Highlight and manage TODO comments.

### CMP and Snippets
- **hrsh7th/nvim-cmp:** Completion framework.
- **hrsh7th/cmp-nvim-lsp:** LSP completion source.
- **rafamadriz/friendly-snippets:** Predefined snippets.
- **iurimateus/luasnip-latex-snippets.nvim:** Latex snippets for LuaSnip.

### File Management
- **stevearc/oil.nvim:** Modern file explorer.
- **nvim-tree/nvim-web-devicons:** Icons for files.

### UI Enhancements
- **lukas-reineke/indent-blankline.nvim:** Indent guides.
- **akinsho/toggleterm.nvim:** Terminal management.
- **folke/noice.nvim:** Improved notifications.
- **rcarriga/nvim-notify:** Notification system.
- **goolord/alpha-nvim:** Customizable start screen.

### Git Integration
- **tpope/vim-fugitive:** Git commands in Neovim.
- **lewis6991/gitsigns.nvim:** Git signs and diffs.
- **sindrets/diffview.nvim:** Enhanced git diffs.

### AI Assistance
- **zbirenbaum/copilot-cmp:** Copilot integration with completion.
- **zbirenbaum/copilot.lua:** Copilot plugin.
- **yetone/avante.nvim:** AI-powered coding assistance.

### Tex Support
- **lervag/vimtex:** Comprehensive Tex support.

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

