if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v light > /dev/null 2>&1; then
    sudo pacman -Syu light --noconfirm --needed >> "$SETUP_LOG"
fi
