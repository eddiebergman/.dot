if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v nvim > /dev/null 2>&1; then
    sudo pacman -Su neovim --needed --noconfirm >> "$SETUP_LOG"
    [[ $DESKTOP_ENV ]] && sudo pacman -Su python-pynvim --needed --noconfirm >> "$SETUP_LOG"
fi

[[ -d "$HOME/.config/nvim" ]] || mkdir -p $HOME/.config/nvim
[[ -d "$HOME/.vim" ]] || mkdir -p $HOME/.vim
[[ -d "$VUNDLE_DIR" ]] && rm -rf "$VUNDLE_DIR"

ln -sfn $DOT_DIR/.vim/.nvim_init.vim $HOME/.config/nvim/init.vim
ln -sfn $DOT_DIR/.vim/.vimrc $HOME/.vimrc
ln -sfn $DOT_DIR/.vim/snips $HOME/.vim/snips
ln -sfn $DOT_DIR/.vim/ftplugin $HOME/.vim/ftplugin

VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR" >> "$SETUP_LOG"
nvim +PluginInstall +qall >> "$SETUP_LOG"

if [[ "$SETUP_TYPE" == "desktop" ]]; then
    # General
    ( command -v python > /dev/null 2>&1) || (sudo pacman -Su python --noconfim --needed >> "$SETUP_LOG")

    # YouCompleteMe
    ( command -v node > /dev/null 2>&1) || (sudo pacman -Su nodejs --noconfim --needed >> "$SETUP_LOG")
    ( pacman -Qi jdk12-openjdk > /dev/null 2>&1) || (sudo pacman -Su jdk12-openjdk --noconfim --needed >> "$SETUP_LOG")
    ( command -v npm > /dev/null 2>&1) || (sudo pacman -Su npm --noconfim --needed >> "$SETUP_LOG")
    ( command -v cmake > /dev/null 2>&1) || (sudo pacman -Su cmake --noconfim --needed >> "$SETUP_LOG")
    ( command -v clang > /dev/null 2>&1) || (sudo pacman -Su clang --noconfim --needed >> "$SETUP_LOG")
    python3 $HOME/.vim/bundle/YouCompleteMe/install.py --ts-completer --clang-completer --java-completer >> "$SETUP_LOG"

    # CtrlSF
    ( command -v ack > /dev/null 2>&1) || (sudo pacman -Su ack --noconfim --needed >> "$SETUP_LOG")
fi
