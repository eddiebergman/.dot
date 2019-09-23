# Includes:
# 	core: ufw, zsh, git, vim
# 
# Should be enough for going onto most new machines and
# doing basic work
sudo echo "Sudo mode" >/dev/null

####################
# Envrionement Setup
####################
# Make sure the script is operating from where intended, hence know
# as $DOT_DIR
CUR_DIR=$(dirname "$(readlink -f "$0")")
source $CUR_DIR/.zsh/.zshenv # Gets our environment variables
if [[ -z "$DOT_DIR" ]]; then
	echo ".zshenv did not load properly or is missing \$DOT_DIR, please investigate"
	exit 1
fi
if [[ "$CUR_DIR" != "$DOT_DIR" ]]; then
	echo ".dot doesn't seems to be mouted at $DOT_DIR, fix the script and .zshenv interaction \\
		or mount as needed"
	exit 1
fi

SETUP_SCRIPT=true
SETUP_TYPE="core"
SETUP_LOG="$DOT_DIR/log/setuplog.txt"
if [[ ! -d "$DOT_DIR/log" ]]; then
	mkdir -p $DOT_DIR/log
fi

export SETUP_SCRIPT
export SETUP_TYPE
export SETUP_LOG

# Yes this probably shouldn't be done but for personal
# use it's not too much of an issue
sudo chmod -R u+x $DOT_DIR/installers

####################
# Installation
####################
echo "Installation start" >> $SETUP_LOG 

./installers/ufw.install.sh
./installers/zsh.install.sh
# ./installers/git.install.sh
# ./installers/nvim.install.sh

if ! command -v git >/dev/null; then
	sudo pacman -Syu git -completions --noconfirm --needed >> "$SETUP_LOG"
	ln -sfn $HOME/.gitconfig $DOT_DIR/.gitconfig
	echo "Git: Installed"
else
	echo "Git: Already Installed"
fi

if ! command -v nvim >/dev/null; then
	pacman -Syu nvim --needed --noconfirm >> "$SETUP_LOG"
	# TODO
#else
fi	
