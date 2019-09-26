if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

( command -v firefox > /dev/null 2>&1 ) || ( sudo pacman -Syu firefox --noconfirm --needed >> "$SETUP_LOG" )
