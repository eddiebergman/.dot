if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

( command -v firefox > /dev/null 2>&1 ) || ( sudo pacman -Su firefox --noconfirm --needed >> "$SETUP_LOG" )
( command -v zathura > /dev/null 2>&1 ) || ( sudo pacman -Su zathura --noconfirm --needed >> "$SETUP_LOG" )
( pacman -Qi libreoffice-still > /dev/null 2>&1 ) || ( sudo pacman -Su libreoffice-still --noconfirm --needed "$SETUP_LOG" )
( command -v feh > /dev/null 2>&1 ) || ( sudo pacman -Su feh --noconfirm --needed "$SETUP_LOG" )
( command -v xfce4-screenshooter > /dev/null 2>&1 ) || ( sudo pacman -Su xfce4-screenshooter --noconfirm --needed "$SETUP_LOG" )
