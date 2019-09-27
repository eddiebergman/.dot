if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! pacman -Qg xorg > /dev/null 2>&1; then
    sudo pacman -Syu xorg --noconfirm --needed >> "$SETUP_LOG"
fi

ln -sfn $CONFIG_DIR/.xinitrc $HOME/.xinitrc

if ! pacman -Qg i3 > /dev/null 2>&1; then
    sudo pacman -Syu i3 --noconfirm --needed >> "$SETUP_LOG"
fi

[[ -d "$HOME/.config/i3" ]] || mkdir -p $HOME/.config/i3
ln -sfn $CONFIG_DIR/.i3_config $HOME/.config/i3/config
