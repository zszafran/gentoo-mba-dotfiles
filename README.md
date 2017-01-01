# gentoo-mba-dotfiles

## Prereq

1. MacBookAir 2015 (Early)
2. rEFInd

## Gentoo Mounts and Directories

### Determine Root and Boot UUIDs
```shell
$ blkid

/dev/sda1: LABEL="EFI" UUID="<BOOT_UUID>" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="<BOOT_PART_UUID>"
/dev/sda5: UUID="<ROOT_UUID>" TYPE="ext4" PARTLABEL="Gentoo" PARTUUID="<ROOT_PART_UUID>"
```

### Mount Root
```shell
$ mount "UUID=<ROOT_UUID>" /mnt/gentoo
```

### Mount Boot (EFI)
```shell
$ mkdir -p /mnt/gentoo/mnt/efi
$ mkdir -p /mnt/gentoo/boot
$ mount "UUID=<BOOT_UUID>" /mnt/gentoo/mnt/efi
$ mount --rbind /mnt/gento/mnt/efi/EFI/GENTOO /mnt/gentoo/boot
```

### Mount USB Storage (optional)
```shell
$ mkdir -p /mnt/gentoo/mnt/cdrom
$ mount --rbind /mnt/cdrom /mnt/gentoo/mnt/cdrom
```

### Install Stage 3
```shell
$ wget http://distfiles.gentoo.org/releases/amd64/autobuilds/20161229/stage3-amd64-20161229.tar.bz2 -O /mnt/gentoo/stage3.tar.bz2
$ tar xvjkf /mnt/gentoo/stage3.tar.bz2 -C /mnt/gentoo --overwrite
$ rm /mnt/gentoo/stage3.tar.bz2
```

### Mount Install
```shell
$ mount -t proc proc /mnt/gentoo/proc
$ mount --rbind /sys /mnt/gentoo/sys
$ mount --make-rslave /mnt/gentoo/sys
$ mount --rbind /dev /mnt/gentoo/dev
$ mount --make-rslave /mnt/gentoo/dev
$ chroot /mnt/gentoo /bin/bash
```

## Gentoo Install

### Update Env
```shell
# mkdir -p /usr/portage
$ env-update
$ source /etc/profile
```

### Emerge GCC
```shell
$ emerge --sync
$ emerge --oneshot gcc
$ gcc-config x86_64-pc-linux-gnu-5.4.0
$ source /etc/profile
```

### Emerge Utils
```shell
$ emerge --oneshot binutils glibc
$ emerge --oneshot portage gentoolkit
$ emerge --update --nodeps udev-init-scripts procps
$ emerge --update shadow openrc udev
```

### Emerge System
```shell
$ sh /usr/portage/scripts/bootstrap.sh
$ emerge -e eyetem
```

### Emerge Kernel
```shell
$ emerge sys-kernel/gentoo-sources
$ eselect kernel set 1
```

### Init Git Repo (optional)
```shell
$ mkdir -p /mnt/gentoo/repo
$ git --git-dir=/mnt/gentoo/repo init
$ git --git-dir=/mnt/gentoo/repo remote add origin https://github.com/zszafran/gentoo-mba-dotfiles.git
$ git --git-dir=/mnt/gentoo/repo --work-tree=/mnt/gentoo fetch
$ git --git-dir=/mnt/gentoo/repo --work-tree=/mnt/gentoo checkout --force -t origin/master
$ echo "*" > /mnt/gentoo/repo/.gitignore
```

### Build Kernel
```shell
$ git --git-dir=/mnt/gentoo/repo --work-tree=/mnt/gentoo checkout --force
$ cd /usr/src/linux
$ make olddefconfig
$ make modules_prepare
$ emerge @modules-rebuid
$ make
$ make modules_install
$ make install
```

### Update Scripting
```shell
$ perl-cleaner --reallyall
$ python-updater
```

### Emerge Everything
```shell
$ git --git-dir=/mnt/gentoo/repo --work-tree=/mnt/gentoo checkout --force
$ cat /var/lib/portage/world | xargs -n1 emerge -uv
$ emerge -e system
$ emerge -avDn @world
```

### Repair Emerge
```shell
$ revdep-rebuild
$ emaint --fix
```
