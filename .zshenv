#!/usr/bin/env zsh

# We use .config/zsh

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

if ! source $ZDOTDIR/.zshenv; then
    # echo "FATAL Error: Could not source $ZDOTDIR/.zshenv"
    echo "zsh config should be in .config/zsh"
    return 1
fi
