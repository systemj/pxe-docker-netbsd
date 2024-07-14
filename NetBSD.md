## Download the NetBSD ISO
- https://cdn.netbsd.org/pub/NetBSD/iso/
Download the NetBSD ISO (ex: NetBSD-0.0-i386.iso) and place it in the `iso` directory.

## Setup NetBSD Files
```bash
docker-compose run setup-netbsd
```

## From NetBSD PXE
```bash
boot tftp:netbsd-INSTALL.gz
```
