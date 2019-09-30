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

if ! command -v compton > /dev/null 2>&1; then
    sudo pacman -Syu compton --noconfirm --needed >> "$SETUP_LOG"
fi

[[ -d "$HOME/.config/i3" ]] || mkdir -p $HOME/.config/i3
ln -sfn $CONFIG_DIR/.i3_config $HOME/.config/i3/config

# Light for brightness control
if ! command -v light > /dev/null 2>&1; then
    sudo pacman -Syu light --noconfirm --needed >> "$SETUP_LOG"
fi
sudo usermod -a -G video "$USER"

if ! command -v nm-applet > /dev/null 2>&1; then
    sudo pacman -Syu network-manager-applet --noconfirm --needed >> "$SETUP_LOG"
fi

if ! command -v rofi > /dev/null 2>&1; then
    sudo pacman -Syu rofi --noconfirm --needed >> "$SETUP_LOG"
fi

[[ -d "$HOME/.config/rofi" ]] || mkdir -p $HOME/.config/rofi
ln -sfn $DOT_DIR/configs/rofi_config $HOME/.config/rofi/config

# Include mime type for markdown
ln -sfn $DOT_DIR/mimetypes/text-markdown.xml $HOME/.local/share/mime/packages/text-markdown.xml
update-mime-database ~/.local/share/mime
