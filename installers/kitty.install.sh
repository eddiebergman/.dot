if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v kitty > /dev/null 2>&1; then
    sudo pacman -Syu kitty --noconfirm --needed >> "$SETUP_LOG"
fi

[[ -d $HOME/.config/kitty ]] || mkdir -p $HOME/.config/kitty
ln -sfn $CONFIG_DIR/kitty.conf $HOME/.config/kitty/kitty.conf
