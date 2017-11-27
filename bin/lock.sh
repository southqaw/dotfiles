#!/usr/bin/env bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
#i3lock -i /tmp/screen.png -e
#i3lock -u -i /tmp/screen.png -e
pkill -u $USER -USR1 dunst
# uses i3lock-color-git from the AUR
i3lock -n -i /tmp/screen.png \
    --insidecolor=073642ff --ringcolor=eee8d5ff --line-uses-inside \
    --keyhlcolor=268bd2ff --bshlcolor=6c71c4ff --separatorcolor=00000000 \
    --insidevercolor=b58900ff --insidewrongcolor=dc322fff \
    --ringvercolor=eee8d5ff --ringwrongcolor=eee8d5ff --indpos="x+32:y+747" \
    --radius=17 --veriftext="" --wrongtext=""
pkill -u $USER -USR2 dunst
#rm /tmp/screen.png
