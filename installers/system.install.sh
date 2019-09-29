if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v light > /dev/null 2>&1; then
    sudo pacman -Syu light --noconfirm --needed >> "$SETUP_LOG"
fi

# Include mime type for markdown
ln -sfn $DOT_DIR/mimetypes/text-markdown.xml $HOME/.local/share/mime/packages/text-markdown.xml
update-mime-database ~/.local/share/mime
