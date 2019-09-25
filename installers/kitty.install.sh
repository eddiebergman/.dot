if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v kitty > /dev/null 2>&1; then
    sudo pacman -Syu kitty --noconfirm --needed >> "$SETUP_LOG"
fi

# ln -sfn $DOT_DIR/.zsh/.zshenv $HOME/.zshenv
