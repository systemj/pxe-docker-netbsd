## Download the NetBSD ISO
- https://cdn.netbsd.org/pub/NetBSD/iso/

## Copy required files to tftpboot (example)
```bash
sudo mount -o loop ~/Downloads/NetBSD-10.0-i386.iso /mnt
cp /mnt/i386/installation/misc/pxeboot_ia32.bin tftpboot
cp /mnt/i386/binary/kernel/netbsd-INSTALL.gz tftpboot
```

## Update tftpboot/pxelinux.cfg/default
Add this section:
```
label netbsdi386
menu label NetBSD i386
kernel pxeboot_ia32.bin
```

## tftpboot/boot.cfg
```
banner=Welcome to NetBSD
banner==================
banner=
banner=Please choose an option from the following menu:
menu=Network Install:boot tftp:netbsd-INSTALL.gz
clear=1
timeout=5
```

## From NetBSD PXE
```bash
boot tftp:netbsd-INSTALL.gz
```
