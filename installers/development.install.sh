if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v node > /dev/null 2>&1; then
    sudo pacman -Syu nodejs --noconfirm --needed >> "$SETUP_LOG"
fi
