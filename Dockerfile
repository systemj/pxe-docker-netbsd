FROM ubuntu:22.04

# base updates and os packages
RUN --mount=type=cache,id=apt-cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,id=apt-lib,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,id=debconf,target=/var/cache/debconf,sharing=locked \
<<EOF
    apt update && apt upgrade -y
    apt install -y isc-dhcp-server tftp tftp-server syslinux pxelinux
EOF