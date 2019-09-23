if [[ ! "$SETUP_SCRIPT" ]]; then
	echo "Please run from one of the setup scripts"
	exit 1
fi

if ! command -v git >/dev/null; then
	sudo pacman -Syu git --noconfirm --needed >> "$SETUP_LOG"
fi

ln -sfn $HOME/.gitconfig $DOT_DIR/.gitconfig
