source /.dot/arch_install/arch_install_env

locale-gen
timedatectl set-ntp true
hwclock --systohc
pacman -S grub os-prober intel-ucode efibootmgr wpa_supplicant iw NetworkManager --needed
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Yes this shoudln't be done
sudo sed -i '/%sudo/s/^#//g' /etc/sudoers
sudo groupadd sudo
sudo useradd -m -U -G sudo $USERNAME

# Move the dotfiles to our user directory
cp -r /.dot /home/$USERNAME/.dot
chown -R $USERNAME /home/$USERNAME/.dot 
chgrp -R $USERNAME /home/$USERNAME/.dot

echo "Please enter a password for root"
passwd
echo "Please enter a passwrod for $USERNAME"
passwd $USERNAME

echo "==================================="
echo "Kicking you out of chroot"
echo "Unmount this drive and reboot"
echo "	$ unmount /dev/sda"
echo "You may also want to delete .dot in / when you get a chance"
