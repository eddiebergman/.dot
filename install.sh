sudo echo "Sudo mode" > /dev/null

# Vars
dot=${HOME}/.dot
wmanager=""

# Prompt help
confirm () {
    read -p "${1}? [y|n]" yn
    echo
    if [[ $yn =~ ^[yY]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Copy misc
ln -sfn ${dot}/rcfiles/.xinitrc ${HOME}/.xinitrc

# Zsh
if confirm "zsh"; then
    echo "Getting oh-my-zsh"
    wget -O ./ohmyzsh_install_script https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    chmod +x ./ohmyzsh_install_script
    ./ohmyzsh_install_script
    rm ./ohmyzsh_install_script

    echo "Getting autosuggestions and syntax hilighting"
    if [[ -z $ZSH_CUSTOM ]]; then
        ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom
    fi
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions &1>/dev/null
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting &1>/dev/null

    echo "Linking"
    ln -sfn ${dot}/.config/zsh/.zshenv ${HOME}/.zshenv
    ln -sfn ${dot}/.config/zsh ${HOME}/.config/zsh

    chsh -s /usr/bin/zsh
fi

# Kitty
if confirm "kitty"; then

    echo "Installing kitty through pacman"
    ( command -v kitty > /dev/null 2>&1 || sudo pacman -Su kitty --noconfirm --needed)

    echo "Linking"
    ln -sfn ${dot}/.config/kitty ${HOME}/.config/kitty
fi

# Rofi
if confirm "rofi"; then
    echo "Installing"
    ( command -v rofi > /dev/null 2>&1 && sudo pacman -Su rofi --noconfirm --needed)
    
    echo "Linking"
    ln -sfn ${dot}/.config/rofi ${HOME}/.config/rofi
fi

# i3
if confirm "i3"; then
    echo "Installing"
    ( pacman -Qg xorg > /dev/null 2>&1 || sudo pacman -Su xorg --noconfirm --needed)
    ( pacman -Qg i3 > /dev/null 2>&1 || sudo pacman -Su i3 --noconfirm --needed)
fi

# qtile
if confirm "qtile"; then
    echo "Installing"
    ( pacman -Qg qtile > /dev/null 2>&1 || sudo pacman -Su qtile --noconfirm --needed)
fi

# python
if confirm "pyenv"; then
    echo "Installing"
    sudo pacman -Su base-devel openssl zlib xz --noconfirm --needed
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

# firefox
if confirm "firefox"; then
    echo "Installing"
    ( command -v firefox > /dev/null 2>&1 || sudo pacman -Su firefox --noconfirm --needed)
fi

# qtile
if confirm "nvim"; then
    echo "Installing"
    sudo pacman -Su base-devel cmake unzip ninja tree-sitter curl --noconfirm --needed
    if [ ! -d "${HOME}/software" ]; then
        mkdir ${HOME}/software
    fi

    git clone https://github.com/neovim/neovim ${HOME}/software/neovim

    here=$(pwd)
    cd ${HOME}/software/neovim
    sudo make CMAKE_BUILD_TYPE=Release
    sudo make install
    cd $here

    ln -sfn ${dot}/.config/nvim/.vimrc ${HOME}/.vimrc
    ln -sfn ${dot}/.config/nvim ${HOME}/.config/nvim

    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
fi

