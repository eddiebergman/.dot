if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! pacman -Qg xorg > /dev/null 2>&1; then
    sudo pacman -Syu xorg xorg-server xorg-init --noconfirm --needed >> "$SETUP_LOG"
fi

ln -sfn $CONFIG_DIR/.xinitrc $HOME/.xinitrc
