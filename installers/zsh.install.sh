if [[ ! "$SETUP_SCRIPT" ]]; then
	echo "Please run from one of the setup scripts"
	exit 1
fi

if ! command -v zsh >/dev/null; then
	sudo pacman -Syu zsh zsh-completions --noconfirm --needed >> "$SETUP_LOG"
	ln -sfn $DOT_DIR/.zsh/.zshenv $HOME/.zshenv
	echo "Zsh: installed"
else
	echo "Zsh: already installed"
fi
