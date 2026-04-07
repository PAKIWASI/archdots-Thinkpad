


if [[ $- == *i* ]]; then
    
    # Skip display in neovim terminal or tmux popup             set in .tmux.conf
    if [ -n "$NVIM" ] || [ "$TERM_PROGRAM" = "nvim" ] || [ -n "$TMUX_POPUP" ]; then
       # Clear on popup terminal (it does not support pics)
       # if [ -n "$TMUX_POPUP" ]; then
       #     clear
       # fi
    else
        # Regular terminal - decide between fastfetch or random logo
        if [ -n "$TMUX" ]; then
            # In tmux (but not popup) - show random logo
            rand_img
        else
            # In normal kitty terminal (not tmux) - show fastfetch
            # if command -v fastfetch >/dev/null; then
            #     if do_render "image"; then
            #         fastfetch --logo-type kitty
            #     fi
            # fi
            fastfetch.sh
        fi
    fi
fi


