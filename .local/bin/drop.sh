#! /bin/bash

#=============================================================
#   Drop - Set a directory as a target to send files to
#=============================================================



# persist drop target over multiple script calls
CONFIG="./drop_target"

# default directory target, set when resetting dir (called by user)
DEFAULT_DROP_DIR="$HOME"

# load the initial drop target from the config file
dir = 


case "$1" in

    # show current drop target
    dir)

    # set new drop target
    setdir)
        dir="${2:-.}"   # use arg or current directory if no arg
        mkdir -p "$(dirname "$CONFIG")"
        echo "$dir" > "$CONFIG"
        echo "Drop target set to: $dir"
        ;;

    # reset drop dir to default directory
    reset)
        dir=$DEFAULT_DROP_DIR
        echo "$dir" > "$CONFIG"
        echo "Drop target reset to: $dir"
        ;;


