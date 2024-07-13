# PXE Boot Via Docker Compose

## Initialize
This creates required files in `tftpboot` and a default `dhcpd.conf`.
```bash
docker-compose run setup
```

## Configure

## dhcpd.env
Update `INTERFACESv4` in `dhcpd.env` to match your local interface name.

Example:
```bash
INTERFACESv4=enp5s0
```

## dhcpd.conf
Update the default `dhcpd.conf` that gets created with your own subnets, clients etc.

Example:
```conf
option domain-name "localdomain";
option domain-name-servers 1.1.1.1, 8.8.8.8;

default-lease-time 600;
max-lease-time 7200;

ddns-update-style none;

subnet 192.168.86.0 netmask 255.255.255.0 {
}

host jetway {
    hardware ethernet  00:30:18:b0:0e:a3;
    server-name "jetway.localdomain";
    fixed-address 192.168.86.123;
    next-server 192.168.86.42;
    filename "pxelinux.0";
}
``` 

## tftpboot/pxelinux.cfg/default
```
default menu.c32
prompt 0
timeout 300
ontimeout internaldrive
menu title PXE Boot Menu

label internaldrive
menu label Boot from internal drive
localboot 0

label netbsdi386
menu label NetBSD i386
kernel pxeboot_ia32.bin
```

## References
- https://www.linux.org/threads/lfcs-%E2%80%93-understanding-pxe-boot.44379/
- https://linux.die.net/man/8/in.tftpd
