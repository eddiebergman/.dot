# .dot
__Note:__ _This installation has not been done on a dry run and may encounter an issue.
Its main use is as a quick reminder for myself, there will be bugs until properly tested_

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

#### Admin
Used for general administrative tasks on arch machines.
__TODO:__ List packages

#### Desktop
User for my general setup, includes most things I would need and is ever expanding.
__TODO:__ List packages

## Installing Arch
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

* Use the default __ext4__ for our general filesystem

    `$ mkfs.ext4 /dev/sda3`

    `$ mkfs.ext4 /dev/sda4`

* Set the `/boot/efi` drive to a UEFI bootable format, __FAT32__ is general

    `$ mkfs.vfat -F 32 /dev/sda1`

* Turn our SWAP partition into a swap  

    `$ mkswap /dev/sda2`

    `$ swapon /dev/sda2`

* Mount our general file system partitions

    `$ mount /mnt/ /dev/sda3`

    `$ mount /mnt/home /dev/sda4`

* Mount our boot loader configuration

    `$ mount /mnt/boot/efi /dev/sda1`

* Save the mount information for when booting

    `$ genfstab -U /mnt >> /mnt/etc/fstab`

* Use pacstrap to get the essentials in (/etc /var /proc ...)

    `$ pacstrap /mnt base base-devel`


* \[For wifi\]
    * Check the name of your interface

       `$ ip link`

    * Set the interface to be active if required, in this case our interface is called `wlp1s0`

       `$ ip link set wlp1s0 up`

    * Use a wifi-menu to connect easily and follow through and select your network

        `$ wifi-menu`

* Get and use git to download our dotfiles to our new device

    `$ sudo pacman -Sy git`

    `$ git clone <repo> /mnt/.dot`

### Configure our system and get boot ready
This has been converted into a script to be run in `.dot/arch_install`.
* Chroot into our new device

    `$ arch-chroot /mnt`

* Configure environment variables to your liking.

    `$ vim .dot/arch_install/arch_install_en`

* Run the setup script, note this installs intel specific microcode things. Please see
the Arch install wiki and configure as needed.

    `$ bash /.dot/arch_install/setup.intel.sh`

* Unmount the device recursively

    `$ umount -R /dev/sda`

* Reboot and bootload from our new drive

    `$ reboot now`

### Choosing a configuration

* Log in the tty as your username

* Setting up wifi connection using `NetworkManager` and WPA2 security

    `$ nmcli device wifi list`

    `$ nmcli device wifi connect _SSID_ password _password_`

* Enable this connection on boot

    `$ sudo systemctl enable NetworkManager`

* If there are issues, you make have to disable other network services if thet exist.

    `$ systemctl --type=service`

    `$ sudo systemctl disable _servicename_`

    * May require a reboot

        `$ sudo reboot now`

* Choose a configuration to install on the system

    `$ bash $HOME/.dot/setup.desktop.sh`

    `$ bash $HOME/.dot/setup.admin.sh`


