if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

# General collection of BitMap fonts
( pacman -Qi bdf-unifont > /dev/null > 2>&1 ) || ( sudo pacman -Syu bdf-unifont --needed -noconfirm >> "$SETUP_LOG" )

# Some fonts I like
( fc-list | grep 'Fira Code' ) || ( sudo pacman -Syu ttf-fira-code otf-fira-code --needed --noconfirm >> "$SETUP_LOG")
( fc-list | grep 'roboto' ) || ( sudo pacman -Syu ttf-roboto --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'ubuntu' ) || ( sudo pacman -Syu ttf-ubuntu-font-family --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'droid' ) || ( sudo pacman -Syu ttf-droid --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'noto' ) || ( sudo pacman -Syu noto-fonts --needed --noconfirm >> "$SETUP_LOG" )
( fc-list | grep 'dejavu' ) || ( sudo pacman -Syu  ttf-dejavu --needed --noconfirm >> "$SETUP_LOG" )

