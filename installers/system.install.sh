if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v light > /dev/null 2>&1; then
    sudo pacman -Syu light --noconfirm --needed >> "$SETUP_LOG"
fi

if ! command -v NetworkManager > /dev/null 2>&1; then
    sudo pacman -Syu networkmanager --noconfirm --needed >> "$SETUP_LOG"
fi

if ! command -v nm-applet > /dev/null 2>&1; then
    sudo pacman -Syu network-manager-applet --noconfirm --needed >> "$SETUP_LOG"
fi

if ! command -v rofi > /dev/null 2>&1; then
    sudo pacman -Syu rofi --noconfirm --needed >> "$SETUP_LOG"
fi

# Include mime type for markdown
ln -sfn $DOT_DIR/mimetypes/text-markdown.xml $HOME/.local/share/mime/packages/text-markdown.xml
update-mime-database ~/.local/share/mime
