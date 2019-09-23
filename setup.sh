sudo echo "Sudo mode"

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

###############
# ufw firewall
###############

#######
# Zsh
#######
if ! command -v zsh >/dev/null; then
	sudo pacman -Syu zsh zsh-completions --noconfirm --needed >> "$SETUP_LOG"
	ln -sfn $TEMP_DOT_DIR/.zsh/.zshenv $HOME/.zshenv
	echo "Zsh: installed"
else
	echo "Zsh: already installed"
fi

#######
# Xorg
#######
if ! pacman -Qg xorg >/dev/null; then
	sudo pacman -Syu xorg --needed -noconfirm
	echo "Xorg: Installed"
else
	echo "Xorg: Already Installed"
fi	

########
# Gnome
########
if ! command -v nvim >/dev/null; then
else
fi	


########
# Nvim
########
if ! command -v nvim >/dev/null; then
else
fi	

########
# Nvim
########
if ! command -v nvim >/dev/null; then
else
fi	
# Replace symlinks if already exists and place startup files
ln -sfn $TEMP_DOT_DIR/.xinitrc $HOME/.xinitrc
#command -v kitty >/dev/null 2>&1 || ( echo -e "Install: Kitty" \
#	&& sudo pacman -Syu kitty --no-confirm --needed	>> $LOG )

chsh -s /usr/bin/zsh
