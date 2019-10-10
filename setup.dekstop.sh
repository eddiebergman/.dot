# Used for my general desktop working enviornment
sudo echo "Sudo mode" > /dev/null

# Envrionement Setup
#
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

SETUP_LOG="$DOT_DIR/log/setuplog.txt"
[[ -d "$DOT_DIR/log" ]] || mkdir -p $DOT_DIR/log

# Installation
echo "Installation start, may take a while. Please see $SETUP_LOG \
    for progress updates or potential errors"

#
# system utilities - things I will forget are installed
#
( command -v ack > /dev/null 2>&1 || sudo pacman -Su ack --noconfim --needed >> "$SETUP_LOG")
( command -v ufw > /dev/null 2>&1 || sudo pacman -Su ufw --noconfirm --needed >> "$SETUP_LOG" )
sudo ufw enable >> "$SETUP_LOG"
sudo systemctl enable ufw.service >> "$SETUP_LOG"

( command -v ssh-keygen > /dev/null 2>&1 || sudo pacman -Su openssh --noconfirm --needed >> "$SETUP_LOG" )
( command -v xclip > /dev/null 2>&1 || sudo pacman -Su xclip --noconfirm --needed >> "$SETUP_LOG" )
( command -v light > /dev/null 2>&1 || sudo pacman -Su light --noconfirm --needed >> "$SETUP_LOG" )
sudo usermod -a -G video "$USER" # Enables lighting control

#
# display - on the tenth day, he gave un to us windows (not the OS, that was the 15th day)
#
( pacman -Qg xorg > /dev/null 2>&1 || sudo pacman -Su xorg --noconfirm --needed >> "$SETUP_LOG" )
ln -sfn $DOT_DIR/.xinitrc $HOME/.xinitrc

( pacman -Qg i3 > /dev/null 2>&1 || sudo pacman -Su i3 --noconfirm --needed >> "$SETUP_LOG" )
[[ -d "$HOME/.config/i3" ]] || mkdir -p $HOME/.config/i3
[[ -d "$HOME/.config/i3status" ]] || mkdir -p $HOME/.config/i3status
ln -sfn $CONFIG_DIR/i3/config $HOME/.config/i3/config
ln -sfn $CONFIG_DIR/i3status/config $HOME/.config/i3status/config

( command -v compton > /dev/null 2>&1 || sudo pacman -Su compton --noconfirm --needed >> "$SETUP_LOG" )

#
# Apps - appra-kadabra
#
( command -v rofi > /dev/null 2>&1 && sudo pacman -Su rofi --noconfirm --needed >> "$SETUP_LOG" )
[[ -d "$HOME/.config/rofi" ]] || mkdir -p $HOME/.config/rofi
ln -sfn $CONFIG_DIR/rofi/config $HOME/.config/rofi/config

( command -v firefox > /dev/null 2>&1 || sudo pacman -Su firefox --noconfirm --needed >> "$SETUP_LOG" )

# Zathura file viewing
( command -v zathura > /dev/null 2>&1 || sudo pacman -Su zathura --noconfirm --needed >> "$SETUP_LOG" )
[[ -f "/usr/lib/zathura/libpdf-mupdf.so" ]] || ( sudo pacman -Su zathura-pdf-mupdf --noconfirm --needed >> "$SETUP_LOG")

( pacman -Qi libreoffice-still > /dev/null 2>&1 || sudo pacman -Su libreoffice-still --noconfirm --needed "$SETUP_LOG" )
( command -v feh > /dev/null 2>&1 || sudo pacman -Su feh --noconfirm --needed "$SETUP_LOG" )
( command -v xfce4-screenshooter > /dev/null 2>&1 || sudo pacman -Su xfce4-screenshooter --noconfirm --needed "$SETUP_LOG" )

#
# zsh - shell
#
( command -v zsh > /dev/null 2>&1 || sudo pacman -Su zsh zsh-completions --noconfirm --needed >> "$SETUP_LOG" )
ln -sfn $ZSH_DIR/.zshenv $HOME/.zshenv
ln -sfn $ZSH_DIR/.zshrc $HOME/.zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k $SHARE_DIR/powerlevel10k

#
# git - you should know what this is
#
( command -v git > /dev/null 2>&1  || sudo pacman -Su git --noconfirm --needed >> "$SETUP_LOG" )
ln -sfn $DOT_DIR/.gitconfig $HOME/.gitconfig

#
# nvim - edit text you say?
#
( command -v nvim > /dev/null 2>&1  || sudo pacman -Su neovim python-pynvim --needed --noconfirm >> "$SETUP_LOG" )
( [[ -d "$HOME/.config/nvim" ]] || mkdir -p $HOME/.config/nvim )
( [[ -d "$HOME/.vim" ]] || mkdir -p $HOME/.vim )

ln -sfn $VIM_DIR/.vimrc $HOME/.vimrc
ln -sfn $VIM_DIR/snips $HOME/.vim/snips
ln -sfn $VIM_DIR/ftplugin $HOME/.vim/ftplugin
ln -sfn $VIM_DIR/plugin $HOME/.vim/plugin
ln -sfn $CONFIG_DIR/nvim/init.vim $HOME/.config/nvim/init.vim

VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
( [[ -d "$VUNDLE_DIR" ]] || rm -rf "$VUNDLE_DIR" )
git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR" >> "$SETUP_LOG"

#
# Java - I'd prefer a coffer to be honset
#
( pacman -Qi jdk12-openjdk > /dev/null 2>&1) || (sudo pacman -Su jdk12-openjdk --noconfim --needed >> "$SETUP_LOG")

#
# C/C++ - hey look at me, im a systems programmer
#
( command -v cmake > /dev/null 2>&1) || (sudo pacman -Su cmake --noconfim --needed >> "$SETUP_LOG")
( command -v clang > /dev/null 2>&1) || (sudo pacman -Su clang --noconfim --needed >> "$SETUP_LOG")

#
# python - you snake
#
( command -v python > /dev/null 2>&1) || (sudo pacman -Su python --noconfim --needed >> "$SETUP_LOG" )
( command -v pip > /dev/null 2>&1 || sudo pacman -Su python-pip --noconfirm --needed >> "$SETUP_LOG" )
([[ -d "$HOME/venvs/py" ]] || ( mkdir -p "$HOME/venvs"  && python -m venv "$HOME/venvs/py" )

#
# Javascript - lets hope I never have to use any of this
#
( command -v node > /dev/null 2>&1) || (sudo pacman -Su nodejs --noconfim --needed >> "$SETUP_LOG")
( command -v npm > /dev/null 2>&1) || (sudo pacman -Su npm --noconfim --needed >> "$SETUP_LOG")

#
# Latex - \begin{}
#
( pacman -Qg texlive-most > /dev/null 2>&1 || sudo pacman -Su texlive-most --noconfirm --needed >> "$SETUP_LOG" )
( pacman -Qi biber > /dev/null 2>&1 || sudo pacman -Su biber --noconfirm --needed >> "$SETUP_LOG")
ln -sfn $DOT_DIR/.latexmkrc $HOME/.latexmkrc

#
# Kitty - dog, cat or terminal kind of person?
# 
( command -v kitty > /dev/null 2>&1 || sudo pacman -Su kitty --noconfirm --needed >> "$SETUP_LOG")
( [[ -d $HOME/.config/kitty ]] || mkdir -p $HOME/.config/kitty )
ln -sfn $CONFIG_DIR/kitty/kitty.conf $HOME/.config/kitty/kitty.conf


#
# Extra steps - could do with a walk
#
nvim +PluginInstall +qall >> "$SETUP_LOG"

python3 $HOME/.vim/bundle/YouCompleteMe/install.py --ts-completer --clang-completer --java-completer >> "$SETUP_LOG"

ln -sfn $DOT_DIR/mimetypes/text-markdown.xml $HOME/.local/share/mime/packages/text-markdown.xml
update-mime-database ~/.local/share/mime

# Finally ask to change shell to zsh
chsh -s /usr/bin/zsh
