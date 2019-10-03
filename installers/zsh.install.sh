if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v zsh > /dev/null 2>&1; then
    sudo pacman -Su zsh zsh-completions --noconfirm --needed >> "$SETUP_LOG"
fi

# .zshenv specifies a ZDOTDIR to point to our dot files
ln -sfn $DOT_DIR/.zsh/.zshenv $HOME/.zshenv
ln -sfn $DOT_DIR/.zsh/.zshrc $HOME/.zshrc
