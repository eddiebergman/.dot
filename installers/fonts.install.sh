if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

# General collection of BitMap fonts
( pacman -Qi bdf-unifont > /dev/null > 2>&1 ) || ( sudo pacman -Su bdf-unifont --needed -noconfirm >> "$SETUP_LOG" )

# Some fonts I like
( fc-list | grep 'Fira Code' ) || ( sudo pacman -Su ttf-fira-code otf-fira-code --needed --noconfirm >> "$SETUP_LOG")
( fc-list | grep 'roboto' ) || ( sudo pacman -Su ttf-roboto --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'ubuntu' ) || ( sudo pacman -Su ttf-ubuntu-font-family --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'droid' ) || ( sudo pacman -Su ttf-droid --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'noto' ) || ( sudo pacman -Su noto-fonts --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'dejavu' ) || ( sudo pacman -Su  ttf-dejavu --needed --noconfirm >> "$SETUP_LOG" )

