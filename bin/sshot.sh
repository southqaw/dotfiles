#!/usr/bin/env bash


VERSION=0.1
version(){ 
echo "Version: $VERSION" 
}

help () {
    echo "Usage: sshot [OPTION]"
    echo "Take screenshot of window or full screen"
    echo
    echo "Options:"
    echo "  -f      Screenshot full screen"
    echo "  -w      Screenshot active window"
    echo "  -h      Display this help and exit"
    echo
    version
    echo
    exit 0
}
full() {
    if [[ $PNG -eq 1 ]]; then
        scrot -d 5 -q 100  ~/Pictures/'%Y-%m-%d_%H:%M:%S_$wx$h.png'
    else
        scrot -d 5 -q 100  ~/Pictures/'%Y-%m-%d_%H:%M:%S_$wx$h.jpg'
    fi
    notify-send "Full snapshot done"

}

window() {
    if [[ $PNG -eq 1 ]]; then
        scrot -d 5 -b -s -q 100  ~/Pictures/'%Y-%m-%d_%H:%M:%S_$wx$h.png'
    else
        scrot -d 5 -b -s -q 100  ~/Pictures/'%Y-%m-%d_%H:%M:%S_$wx$h.jpg'
    fi
    notify-send "Window snapshot done"
}
PNG=0
while getopts ":fwph" opt; do
  case $opt in
    f   ) full; exit 0;;
    w   ) window; exit 0;;
    p   ) PNG=1;;
    h   ) help;;
    \?  ) echo "Invalid option: -$OPTARG" >&2; exit 1;;
  esac
done

echo "No options found. Please enter an option."
echo
help

