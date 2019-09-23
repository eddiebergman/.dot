if [[ ! "$SETUP_SCRIPT" ]]; then
	echo "Please run from one of the setup scripts"
	exit 1
fi

if ! command -v ufw >/dev/null; then
	sudo pacman -Syu ufw --noconfirm --needed >> "$SETUP_LOG"
	sudo ufw enable
	sudo systemctl enable ufw.service
	echo "ufw: Installed"
else
	echo "ufw: Already Installed"
fi
