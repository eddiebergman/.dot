if [[ ! "$SETUP_SCRIPT" ]]; then
    echo "Please run from one of the setup scripts"
    exit 1
fi

if ! command -v ufw >/dev/null; then
    sudo pacman -Syu ufw --noconfirm --needed >> "$SETUP_LOG"
fi

sudo ufw enable >> "$SETUP_LOG"
sudo systemctl enable ufw.service >> "$SETUP_LOG"
