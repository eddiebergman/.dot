if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

( pacman -Qg texlive-most > /dev/null 2>&1 ) || ( sudo pacman -Su texlive-most --noconfirm --needed >> "$SETUP_LOG" )
( pacman -Qi biber > /dev/null 2>&1 ) || ( sudo pacman -Su biber --noconfirm --needed >> "$SETUP_LOG")