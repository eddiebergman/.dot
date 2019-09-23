if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

####################
# Preliminary Setup
####################
TEMP_DOT_DIR="$HOME/.dot"
source $TEMP_DOT_DIR/.zsh/.zshenv 

SETUP_LOG="$DOT_DIR/log/setuplog.txt"
if [[ ! -d "$DOT_DIR/log" ]]; then
	mkdir -p $DOT_DIR/log
fi
echo "Setup start" >> $SETUP_LOG 

#######
# Zsh
#######
if command -v zsh >/dev/null 2>&1; then
	sudo pacman -Syu zsh zsh-completions --no-confirm --needed >> "$SETUP_LOG"
	ln -sfn $TEMP_DOT_DIR/.zsh/.zshenv $HOME/.zshenv
	chsh -s /usr/bin/zsh
	echo "Zsh installed, please restart shell to use" 
else
	echo "Zsh was already installed"
fi


# Replace symlinks if already exists and place startup files
ln -sfn $TEMP_DOT_DIR/.xinitrc $HOME/.xinitrc
#command -v kitty >/dev/null 2>&1 || ( echo -e "Install: Kitty" \
#	&& sudo pacman -Syu kitty --no-confirm --needed	>> $LOG )


