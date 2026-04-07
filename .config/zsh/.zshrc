

# XDG BASE DIRS
# ==================================================
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# EDITOR / ENV
# ==================================================
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# PATH
# ==================================================
export PATH="$HOME/.local/bin:$PATH"

# HISTORY
# ==================================================
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt HIST_VERIFY

# CORE ZSH BEHAVIOR
# ==================================================
setopt AUTO_CD
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER

bindkey -v
export KEYTIMEOUT=1

# COMPLETION SYSTEM (CORE)
# ==================================================
autoload -Uz compinit

# zsh-completions (Arch path)
if [ -d /usr/share/zsh/plugins/zsh-completions ]; then
  fpath=(/usr/share/zsh/plugins/zsh-completions $fpath)
fi

compinit

# completion behavior
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt NUMERIC_GLOB_SORT
setopt NO_CASE_GLOB

# completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# matching: case-insensitive + smart separators
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# DIRECTORY STACK
# ==================================================
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
alias d='dirs -v'

# STARSHIP PROMPT
# ==================================================
export STARSHIP_CONFIG=~/.config/starship/starship.toml
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

# ZOXIDE
# ==================================================
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# FZF (CORE CONFIG)
# ==================================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
  --prompt='❯ '
  --preview-window=right:60%
"

# FZF CTRL-R HISTORY SEARCH (REAL, ZSH-NATIVE)
# ==================================================
fzf-history() {
  local cmd
  cmd=$(
    fc -rl 1 |
    sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' |
    fzf --tac --no-sort --query="$LBUFFER" \
        --prompt='history ❯ '
  ) || return

  LBUFFER="$cmd"
}
zle -N fzf-history
bindkey '^R' fzf-history        # Ctrl R for history search

# HISTORY SUBSTRING SEARCH (↑ ↓)
# ==================================================
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# AUTOSUGGESTIONS
# ==================================================
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^ ' autosuggest-accept

# ALIASES
# ==================================================

# pacman
alias sp='sudo pacman'
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias spsyu='sudo pacman -Syu'
alias spr='sudo pacman -R'
alias sprns='sudo pacman -Rns'
alias spq='sudo pacman -Q'
alias pacorphs='pacman -Qtdq'
alias pacorphs-rm='sudo pacman -Rns $(pacman -Qtdq)'
alias pacforeign='pacman -Qqm'

# directories
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias mkdir='mkdir -p'

# applications
alias pic='kitty icat'
alias camera='guvcview'
alias f='fastfetch --logo-type kitty-icat --logo-width 35'
alias ff='fastfetch -l small'
alias n='nvim'
alias nn='NVIM_APPNAME=nvim012 nvim'
alias C='cmake -G Ninja -S . -B build/'
alias b='ninja -C build'
alias x='./build/main'
alias bx='ninja -C build && ./build/main'

# misc
alias c='clear'


# safety
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'


# dotfiles
alias dots='/usr/bin/git --git-dir=$HOME/Documents/dotfiles/ --work-tree=$HOME'
alias lazydots='lazygit --git-dir=$HOME/Documents/dotfiles --work-tree=$HOME'


# TMUX HELPERS
# ==================================================
tn() {
  [[ $# -eq 0 ]] && echo "Usage: tn <session>" || tmux new-session -s "$1"
}

ta() {
  [[ $# -eq 0 ]] && tmux list-sessions || tmux attach-session -t "$1"
}

alias tl='tmux list-sessions'
alias tks='tmux kill-session'
alias tkS='tmux kill-server'

# tmux cursor fix
if [[ -n "$TMUX" ]]; then
  _tmux_cursor_fix() { echo -ne '\e[5 q'; }
  precmd_functions+=(_tmux_cursor_fix)

  zle-keymap-select() {
    [[ $KEYMAP == vicmd ]] && echo -ne '\e[1 q' || echo -ne '\e[5 q'
    zle reset-prompt
  }
  zle -N zle-keymap-select
fi

# ===== EZA =====
export EZA_THEME=$HOME/.config/eza/theme.yml

alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lls='eza -l --icons --git --total-size'
alias las='eza -la --icons --git --total-size'
# sorting helpers
alias lm='eza -l --sort=modified --icons --git'
alias lz='eza -l --sort=size --icons --git'
alias lx='eza -l --sort=extension --icons --git'
# git-focused
alias lg='eza -l --git --git-ignore --git-repos --icons'
# tree + files
lt() {
    if [[ $# -eq 0 ]]; then
        eza -lT --icons --git -L 1
    else
        eza -lT --icons --git -L "$@"
    fi
}
# tree + git focused
ltg() {
    if [[ $# -eq 0 ]]; then
        eza -lT --icons --git --git-ignore --git-repos -L 1
    else
        eza -lT --icons --git --git-ignore --git-repos -L "$@"
    fi
}
# tree + files + all
lta() {
    if [[ $# -eq 0 ]]; then
        eza -laT --icons --git -L 1
    else
        eza -laT --icons --git -L "$@"
    fi
}
# classic tree replacement
tree() {
    eza --tree --icons "$@"
}


# ===== FZF =====

# fuzzy explore directories with tree preview
fcdt() {
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git \
        | fzf --preview 'eza --tree --level=3 --icons --color=always {}') || return
    cd "$dir"
}

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"


# SYNTAX HIGHLIGHTING (MUST BE LAST)
# ==================================================
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

