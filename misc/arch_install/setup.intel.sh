source /.dot/arch_install/arch_install_env

# Setup timezone
ln -sf /mnt/usr/share/zoneinfo/GMT /mnt/etc/localtime

# Choose locales
sed -i '/en_US.UTF8/s/^#//g' /mnt/etc/locale
locale-gen

# Setup Lang
echo "LANG=en_US.UTF8" >> /mnt/etc/local.conf

# Configure Host
echo "$HOSTNAME" >> /mnt/etc/hostname
echo "127.0.0.1 localhost" >> /mnt/etc/hosts
echo "::1 localhost" >> /mnt/etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /mnt/etc/hosts

# Configure time
timedatectl set-ntp true
hwclock --systohc

# Add some essentials to our new system
pacman -S grub os-prober intel-ucode efibootmgr wpa_supplicant iw NetworkManager --needed --noconfirm

# Allow grub to create a boot folder
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Add a sudo group and create a user
# Yes this shoudln't be done
sudo sed -i '/%sudo/s/^#//g' /etc/sudoers
sudo groupadd sudo
sudo useradd -m -U -G sudo $USERNAME

# Move the dotfiles to our user directory
cp -r /.dot /home/$USERNAME/.dot
chown -R $USERNAME /home/$USERNAME/.dot 
chgrp -R $USERNAME /home/$USERNAME/.dot

# Configure root and user password
echo "================================"
echo "Please enter a password for root"
passwd
echo "================================"
echo "Please enter a passwrod for $USERNAME"
passwd $USERNAME

echo "==================================="
echo "Kicking you out of chroot"
echo "Unmount this drive and reboot"
echo "	$ unmount /dev/sda"
echo "You may also want to delete .dot in / when you get a chance"
