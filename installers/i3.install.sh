if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

# Dependancies
( pacman -Qg xorg >/dev/null 2>&1 ) || $DOT_DIR/installers/xorg.install.sh

if ! pacman -Qg i3 > /dev/null 2>&1; then
    sudo pacman -Syu i3 --noconfirm --needed >> "$SETUP_LOG"
fi

if [[ ! -d "$HOME/.config/i3/config" ]]; then
    mkdir -p $HOME/.config/i3/config
fi

ln -sfn $DOT_DIR/.i3_config $HOME/.config/i3/config
