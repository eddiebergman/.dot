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
( pacman -Qi adobe-source-sans-pro-fonts ) || ( sudo pacman -Su adobe-source-sans-pro-fonts --needed --noconfirm >> "$SETUP_LOG" )
( pacman -Qi gnu-free-fonts ) || ( sudo pacman -Su adobe-source-sans-pro-fonts --needed --noconfirm >> "$SETUP_LOG" )

# Italics version of Fira Code, has to be built from source
if [[ !$( fc-list | grep 'Fira Mono') ]] then;
    # Clone lib
    git clone https://github.com/Avi-D-coder/fira-mono-italic $HOME/fira-mono-italic

    # There's probably a nice way to do this
    [[ -d "${HOME}/.local/share/fonts" ]] || mkdir "${HOME}/.local/fonts"
    [[ -d "${HOME}/.local/share/fonts/otf" ]] || mkdir "${HOME}/.local/share/fonts/otf"
    mkdir "${HOME}/.local/share/fonts/otf/fira-mono"

    cp $HOME/fira-mono-italic/distr/otf/* $HOME/.local/share/fonts/otf/fira-mono
    rm -rf $HOME/fira-mono-italic
fi

# Update the font cache
fc-cache
