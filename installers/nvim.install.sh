if [[ ! "$SETUP_SCRIPT" ]]; then
	echo "Please run from one of the setup scripts"
	exit 1
fi

if ! command -v nvim >/dev/null; then
	pacman -Syu neovim --needed --noconfirm >> "$SETUP_LOG"
fi	

ln -sfn $DOT_DIR/.vim/.vimrc $HOME/.vimrc
ln -sfn $DOT_DIR/.vim $HOME/.vim
