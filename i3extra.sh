#!/bin/bash

i3status --config ~/.config/i3status/config | while :
do
    read line
    LG=$(setxkbmap -query | awk '/layout/{print $2}')
    echo "Keys: $LG | $line" || exit 1
done
