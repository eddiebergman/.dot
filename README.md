# .dot
---
This is a repo I use for quickly installing Arch Linux and my configuration
on a drive. This is done in two steps:

1. **Arch**
    * Once Arch is booted from drive, everything required is in *arch_install*.
    This includes help in booting from an Arch EUFI boot and setting up grub,
    some core system utilities and a sudo user account.

2. **Configuration**
    * Once you've installed Arch on the drive and booted in, run
    one of the setup files that you want to install on the drive.
    See below for the difference.

This is done by keeping all configuration files in *.dot* 
while the scripts go through and download required packages and
and symlinking our files into where they need to
go e.g. .vimrc or .gitconfig.

## Configurations
---

#### Admin
Used for general administrative tasks on arch machines.
__TODO:__ List packages

#### Desktop
User for my general setup, includes most things I would need and is ever expanding.
__TODO:__ List packages

## Installing Arch
---
### Bootloading from USB/disk
* Download the Arch distribution that you would like to install from [here](https://www.archlinux.org/download/)

* Put it on a USB key or cd and boot from it. Each system will have a different
way to turn them into a bootable device and boot from that device.

### Creating your filesystem

* Check how your disks look find drive you're installing on using 

    `$ fdisk -l`.

* Assuming a drive name `/dev/sda`, start partitioning with `cfdisk` where
you can specify paritions with Type, Size. We'll create 4 of them according to the
Arch configuration guide.

    `$ cfdisk /dev/sda`

| Drive | Size | Type |
| ----- | ---- | ---- |
| /dev/sda1 | 260M | EFI System |
| /dev/sda2 | 12G | Linux swap |
| /dev/sda3 | 32G | Linux root (x86) |
| /dev/sda4 | 194.2G  | Linux home |

* Make sure they're all looking good 

    `$ fdisk -l`

* Use thedefault ext4 for our general filesystem

    `$ mkfs.ext4 /dev/sda2`

    `$ mkfs.ext4 /dev/sda3`

5. Set the `/boot/efi` drive to a UEFI bootable format, FAT32 is general
    `:$ mkfs.vfat -F 32 /dev/sda1`

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

#### Setting up wifi 
Find the wireless interface, in my case it was *wlp1s0*
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
