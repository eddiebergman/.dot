source ./arch_install_env

# Let pacstrap install the goods
pacstrap /mnt base base-devel

# Setup timezone
ln -sf /mnt/usr/share/zoneinfo/GMT /mnt/etc/localtime

# Choose locales
sed -i '/en_US.UTF8/s/^#//g' /mnt/etc/locale
echo "LANG=en_US.UTF8" >> /mnt/etc/local.conf

# Keymap

# Hostname
echo "$HOSTNAME" >> /mnt/etc/hostname
echo "127.0.0.1 localhost" >> /mnt/etc/hosts
echo "::1 localhost" >> /mnt/etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /mnt/etc/hosts

# Mount information
genfstab -U /mnt >> /mnt/etc/fstab
cp /root/.dot /mnt/.dot

# Next
echo "Step 0 Complete, chroot-ing you in to /mnt"
echo "Go and run step1.sh"
echo "	$ bash /.dot/arch_install/step1.sh" 
