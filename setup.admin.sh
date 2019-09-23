# Includes:
#     core: ufw, zsh, git, nvim
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
source $CUR_DIR/.zsh/.zshenv

if [[ -z "$DOT_DIR" ]]; then
    echo ".zshenv did not load properly or is missing \$DOT_DIR, please investigate"
    exit 1
fi

if [[ "$CUR_DIR" != "$DOT_DIR" ]]; then
    echo ".dot doesn't seems to be mouted at $DOT_DIR, mounted at $CUR_DIR"
    echo "- If $DOT_DIR doesnt seem correct, try running without sudo '$ ./setup.core.sh'"
    exit 1
fi

SETUP_SCRIPT=true
SETUP_TYPE="admin"

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

./installers/ufw.install.sh
./installers/zsh.install.sh
./installers/git.install.sh
./installers/nvim.install.sh
