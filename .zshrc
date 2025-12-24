 # zmodload zsh/zprof
# ---------------------------------------------
# ZINIT INSTALLATION
# ---------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# ---------------------------------------------
# COMPLETION
# ---------------------------------------------
autoload -Uz compinit
compinit -C

export LS_COLORS="$(vivid generate catppuccin-mocha)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*:commands' command-path /usr/local/bin /usr/bin /bin ~/.local/bin ~/bin

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags --color=bg+:#313244,bg:#1E1E2E -i
export FZF_COMPLETION_OPTS='-i'


# ---------------------------------------------
# ZINIT PLUGINS
# ---------------------------------------------
# Load completions first
# zinit load zsh-users/zsh-completions

# FZF-tab (before compinit, before syntax highlighting)
zinit load Aloxaf/fzf-tab

# Autosuggestions
zinit load zsh-users/zsh-autosuggestions

# Autopair
zinit light hlissner/zsh-autopair

# Sudo plugin
zinit snippet OMZP::sudo

# Colored man pages
zinit snippet OMZP::colored-man-pages

# Vi-mode
zinit snippet OMZP::vi-mode
VI_MODE_SET_CURSOR=true

# IMPORTANT: fast-syntax-highlighting MUST be loaded LAST
zinit light zdharma-continuum/fast-syntax-highlighting

# ---------------------------------------------
# EXTERNAL TOOLS
# ---------------------------------------------
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# eval "$(atuin init zsh)"

# Lazy load carapace
eval "$(command carapace _carapace)"

# Zinit uses 'zi' as shortcut, but we want zoxide's interactive selector
alias zi='__zoxide_zi'


# ---------------------------------------------
# HISTORY
# ---------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_VERIFY

# ---------------------------------------------
# ZSH OPTIONS
# ---------------------------------------------
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt EXTENDED_GLOB NULL_GLOB NO_BEEP INTERACTIVE_COMMENTS



# ---------------------------------------------
# ALIASES
# ---------------------------------------------
alias zshconfig="nvim ~/.zshrc"
alias g="git"
alias v="nvim"
alias cat="bat --style=plain"
alias ls="eza --icons --color=always"
alias ll="eza -la --icons --color=always --group-directories-first"
alias la="eza -la --icons --color=always"
alias lt="eza --tree --icons --color=always --level=2"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# zprof
