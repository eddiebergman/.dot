if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v nvim > /dev/null 2>&1; then
    sudo pacman -Syu neovim --needed --noconfirm >> "$SETUP_LOG"
fi

# Nvim setup to point to placed vimrc
if [[ ! -d "$HOME/.config/nvim" ]]; then
    mkdir -p $HOME/.config/nvim
fi

ln -sfn $DOT_DIR/.vim/.nvim_init.vim $HOME/.config/nvim/init.vim
ln -sfn $DOT_DIR/.vim/.vimrc $HOME/.vimrc
[[ -d "$HOME/.vim" ]] || mkdir -p $HOME/.vim
ln -sfn $DOT_DIR/.vim/snips $HOME/.vim/snips

VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
[[ -d "$VUNDLE_DIR" ]] || rm -rf "$VUNDLE_DIR"
git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR" >> "$SETUP_LOG"
nvim +PluginInstall +qall >> "$SETUP_LOG"
