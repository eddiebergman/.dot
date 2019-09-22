DOT_DIR=$HOME/.dot
ZSH_DIR=$DOT_DIR/.zsh

sudo pacman -Syu zsh zsh-completions

# Unfortunatly there's not really a nice portable way
# except to have envs set in HOME
if [[ ! -f "$HOME/.zshenv" ]]; then
	ln -s $ZSH_DIR/.zshenv $HOME/.zshenv
fi

chsh -s /usr/bin/zsh
exit
