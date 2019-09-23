if [[ -z "$SETUP_LOG" ]]; then
	echo "Please specify a \$SETUP_LOG, SETUP_LOG=path/to/file ./module.install.sh"
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
