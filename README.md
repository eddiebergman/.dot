####################################
# Setting up wifi 
####################################
Find the wireless interface <wlp1s0> 
    $ ip link

Setup to wifi, can use iw but this worked for WPA based encryption
    $ wifi_menu

Turn on the network interface
    $ ip link set <interface> up

Check its status
    $ ip link

Make sure it works
    $ ping -c 3 google.com

####################################
# Filesystem
####################################

# Paritioning
####################################
Check how your disks lookm find drive you're installing on
    $ fdisk -l

Assuming /dev/sda/, partition with cfdisk where you can specify
paritions with Type, Size. Create 4 of them according to Arch
installation.
    $ cfdisk /dev/sda/
        Mount        Type        Size    Name
        -----        ----        ----    ----
        /mnt/boot/efi    EFI        260MB    sda1
        /mnt/        Linux Root    32GB    sda2
        /mnt/ho        Linux Home    Rest    sda3
        SWAP        Linux Swap    <?>    sda4

Make sure they're all looking good
    $ fdisk -l

# Filesystem creation and mounting
####################################
Use thedefault ext4 for our general filesystem
    $ mkfs.ext4 /dev/sda2
    $ mkfs.ext4 /dev/sda3

Set the /boot/efi drive to a UEFI bootable format, FAT32 is general
    $ mkfs.vfat -F 32 /dev/sda1 

Turn our SWAP partition into a swap  
    $ mkswap /dev/sda4
    $ swapon /dev/sda

Mount our general file system partitions
    $ mount /mnt/ /dev/sda2
    $ mount /mnt/home /dev/sda3

Mount our boot loader configuration
    $ mount /mnt/boot/efi /dev/sda1

Use pacstrap to get the essentials in (/etc /var /proc ...)
    $ pacstrap /mnt base base-devel

Use git to download our dotfiles
    $ git clone <repo> /mnt/.dot

# Configure our system and get boot ready
####################################
Save our mount configuration in fstab for where we reboot
    $ genfstab -U /mnt >> /mnt/etc/fstab

Chroot into are new setup
    $ arch-chroot /mnt 

Setup our localtime
    $ ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime

Enable Network Time Protocol for getting time from the network 
    $ timedatectl set-ntp true

Setup our hardware clock
    $ hwclock --systohc

Uncomment from /etc/locale.gen the locals you want installed ('en_US.UTF8')
    $ locale-gen

Insert the following into /etc/local.conf to choose which default lang lcole to use
    $ echo "LANG=en_US.UTF8" >> /etc/local.conf

[Optional] Insert KEYMAP that you want
    $ echo "KEYMAP=de-latin1" >> etc/vconsole.conf

Create the hostname file
    $ echo "<hostname>" >>  /etc/hostname 

Add matching entries to hosts
    $ vi /etc/hosts
        127.0.0.1         localhost    
        ::1            localhost
        127.0.1.1        <hostname>.localdomain <hostname>


# Setting up Grub for configuring boot loading
####################################
Install a few packages (intel-ucode is for intel cards to fix some microcode issues)
    $ pacman -S grub os-prober intel-ucode efibootmgr wpa_supplicant dialog iw

Install grub on our drive
    $ grub-install /dev/sda

Create the config for grub, should have goot defaults
    $ grub-mkconfig -o /boot/grub/grub.cfg

Create a passwd for root
    $ passwd

Exit chroot
    $ exit

Unmount our setup, will be mounted by fstab on /
    $ umount -R /mnt

Detach the usb drive and hopefully on reboot we should boot load Arch Linux
    $ reboot

####################################
# Create a user
####################################
Creat a user with a home mounter on /home/<user>  (-m)
    $ useradd -m <user>

Create a password for the user
    $ passwd <user>

Add new user to sudoers
    $ groupadd sudo
    $ usermod -a -G sudo <user>
    $ visudo /etc/sudoers
        # Uncomment sudo group

Delete our netctl profile while still in root
    $ rm /etc/netctl/<interface>

Move our dot files to the new users space
    $ mv /.dot /home/<usr>/.dot
    $ chown -R /home/<usr>/.dot <user>

Switch to our new user
    $ su <user>

##################################o#
# Enable and set up wifi for actual arch on device
####################################
Make sure network interface is down
    $ ip link set <interface> down

Connect to wifi
    $ sudo wifi-menu

Enable netctl of whatever wireless itnerface was set up at /etc/netctl/<interface>
    $ netctl enable /etc/netctl/<interface>
    - may have to sudo this
Need to conisder for display install, using network manager requires netctl to be down and not enabled

Need to disable netctl if enabled and enable network manager if setup.display.sh
Consult ARCH wiki for OpenGL drivers and graphics card drivers
https://wiki.archlinux.org/index.php/Xorg

# Stop and Disable netctl if active
Find netctl service 
$ systemctl --type=service
$ sudo systemctl stop <service>
$ sudo systemctl disable <service>

# Note: Had an issue where I had to reinstall it to get the daemon, when doing all this manually
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
