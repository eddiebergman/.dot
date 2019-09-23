# Includes:
# 	core: ufw, zsh, git, vim
# 
# Should be enough for going onto most new machines and
# doing basic work

#####################
# Prelim. check
#####################
sudo echo "Sudo mode" >/dev/null

# Make sure the script is operating from where intended
CUR_DIR=$(dirname "$(readlink -f "$0")")
if [[ "$CUR_DIR" != "$HOME/.dot" ]]; then
	echo ".dot doesn't seems to be mouted at $HOME/.dot, fix the script and .zshenv interaction \\
		or mount as needed"
	exit 1
fi

####################
# Envrionement Setup
####################
source $CUR_DIR/.zsh/.zshenv 

SETUP_LOG="$DOT_DIR/log/setuplog.txt"
if [[ ! -d "$DOT_DIR/log" ]]; then
	mkdir -p $DOT_DIR/log
fi
echo "Setup start" >> $SETUP_LOG 

###############
# ufw firewall
###############
if ! command -v ufw >/dev/null; then
	sudo pacman -Syu ufw --noconfirm --needed >> "$SETUP_LOG"
	sudo ufw enable
	sudo systemctl enable ufw.service
	echo "ufw: Installed"
else
	echo "ufw: Already Installed"
fi

#######
# Zsh
#######
if ! command -v zsh >/dev/null; then
	sudo pacman -Syu zsh zsh-completions --noconfirm --needed >> "$SETUP_LOG"
	ln -sfn $DOT_DIR/.zsh/.zshenv $HOME/.zshenv
	echo "Zsh: installed"
else
	echo "Zsh: already installed"
fi

######
# Git
######
if ! command -v git >/dev/null; then
	sudo pacman -Syu git -completions --noconfirm --needed >> "$SETUP_LOG"
	ln -sfn $HOME/.gitconfig $DOT_DIR/.gitconfig
	echo "Git: Installed"
else
	echo "Git: Already Installed"
fi

########
# Nvim
########
if ! command -v nvim >/dev/null; then
	pacman -Syu nvim --needed -noconfirm
	# TODO
else
fi	
