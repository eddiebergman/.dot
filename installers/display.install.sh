#if [[ ! "$SETUP_SCRIPT" ]]; then
#    echo "Please run from one of the setup scripts"
#    exit 1
#fi

# Xorg
##########
if ! pacman -Qg xorg > /dev/null 2>&1; then
    sudo pacman -Syu xorg --noconfirm --needed >> "$SETUP_LOG"
fi

# GDM
##########
if ! command -v gdm > /dev/null 2>&1; then
    sudo pacman -Syu gdm --noconfirm --needed >> "$SETUP_LOG"
fi

# TODO may require root pass, figure way arond, possibly run under usr privilege
systemctl enable gdm.service

# TODO Enable touchpad click
# xhost +SI:localuser:gdm # Allow gdm to talk to X server
# sudo -u gdm gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
# Wasn't setting properly, remained false.
# https://wiki.archlinux.org/index.php/GDM#Enabling_tap-to-click

# Disable Wayland backend and use Xorg
# /<pattern>/s/<find>/<replace>/g
# -i , inplace, dont create new file
# <pattern>, execute command where pattern found
# s/ / / , standard regex find replace
sudo sed -i '/WaylandEnable/s/^#//g' /etc/gdm/custom.conf

# TODO enable background image loading for log in
# https://wiki.archlinux.org/index.php/GDM

# Gnome
##########
if ! pacman -Qg gnome > /dev/null 2>&1; then
    sudo pacman -Syu gnome --noconfirm --needed >> "$SETUP_LOG"
fi

# Network GUI
###############
if ! command -v nmcli > /dev/null 2>&1; then
    sudo pacman -Syu networkmanager --noconfirm --needed >> "$SETUP_LOG"
fi
# To prevent any misconfigurations and messing up the build, see README
# for post installation instructions

if ! command -v nm-applet > /dev/null 2>&1; then
    sudo pacman -Syu network-manager-applet --noconfirm --needed >> "$SETUP_LOG"
fi
