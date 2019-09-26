# Includes:
#       admin: ufw, zsh, git, nvim
#       display: xorg, gdm, gnome
# Used for my general desktop working enviornment
sudo echo "Sudo mode" >/dev/null

####################
# Envrionement Setup
####################
# Make sure the script is operating from where intended, hence know
# as $DOT_DIR

CUR_DIR=$(dirname "$(readlink -f "$0")")
sudo sed -i '/DESKTOP_ENV/s/^#*//' $CUR_DIR/.zsh/.zshenv
source $CUR_DIR/.zsh/.zshenv

if [[ -z "$DOT_DIR" ]]; then
    echo ".zshenv did not load properly or is missing \$DOT_DIR, please investigate"
    exit 1
fi

if [[ "$CUR_DIR" != "$DOT_DIR" ]]; then
    echo ".dot doesn't seems to be mouted at $DOT_DIR, mounted at $CUR_DIR"
    echo "- If $DOT_DIR doesnt seem correct, try running without sudo '$ ./setup.desktop.sh'"
    exit 1
fi

SETUP_SCRIPT=true
SETUP_TYPE="desktop"

SETUP_LOG="$DOT_DIR/log/setuplog.txt"
if [[ ! -d "$DOT_DIR/log" ]]; then
    mkdir -p $DOT_DIR/log
fi

#echo "Installation began at: $(date -u)" >> "$SETUP_LOG"

export SETUP_SCRIPT
export SETUP_TYPE
export SETUP_LOG

# Yes this probably shouldn't be done but for personal
# use it's not too much of an issue
sudo chmod -R u+x $DOT_DIR/installers

####################
# Installation
####################
echo "Installation start, may take a while. Please see $SETUP_LOG \
    for progress updates or potential errors"

$DOT_DIR/installers/ufw.install.sh
$DOT_DIR/installers/zsh.install.sh
$DOT_DIR/installers/git.install.sh
$DOT_DIR/installers/nvim.desktop.install.sh

$DOT_DIR/installers/kitty.install.sh
$DOT_DIR/installers/xorg.install.sh
$DOT_DIR/installers/i3.install.sh

$DOT_DIR/installers/apps.install.sh

# Finally ask to change shell to zsh
chsh -s /usr/bin/zsh
