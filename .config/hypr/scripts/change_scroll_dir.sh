#!/bin/bash

dir=$1

if [ -z "$dir" ]; then
    notify-send -u critical "Scroll" "No scroll direction specified"
    exit 1
fi


hyprctl keyword scrolling:direction "$dir" && \
    notify-send -t 1000 "Scroll" "Scroll Direction: ${dir^}" || \
    notify-send -u critical "Scroll" "Failed to change dir to ${dir^}"

