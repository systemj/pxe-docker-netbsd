# PXE Boot Via Docker Compose

A helper project to boot the network install for NetBSD on an old PC.

## Download the NetBSD ISO
Download the NetBSD ISO (ex: NetBSD-0.0-i386.iso) and place it in the `iso` directory.
- https://cdn.netbsd.org/pub/NetBSD/iso/

## Initialize
This creates required pxelinux files in `tftpboot` and a default `dhcpd.conf`.
```bash
docker-compose run setup
```

## Setup NetBSD Files
This adds the necessary files from the NetBSD ISO to `tftpboot` and adds the pxelinux menu entry.
```bash
docker-compose run setup-netbsd
```

## Local Network Configuration

### dhcpd.env
Update `INTERFACESv4` in `config/dhcpd/dhcpd.env` to match your physical host interface name.

Example:
```bash
INTERFACESv4=enp5s0
```

### dhcpd.conf
Update the default `config/dhcpd/dhcpd.conf` that has been created with your specifics for own subnets, clients etc.

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

## PXE Boot NetBSD Install
- Boot the client PC
- At the "PXE Boot Menu" choose "NetBSD i386"
- At the "NetBSD/x86 PXE Boot" screen press any key other than "enter" to access the boot cli.
- Boot the NetBSD Installer and then install via HTTP.
```bash
boot tftp:netbsd-INSTALL.gz
```

## References
- https://www.linux.org/threads/lfcs-%E2%80%93-understanding-pxe-boot.44379/
- https://linux.die.net/man/8/in.tftpd
