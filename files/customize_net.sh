#!/bin/sh

set -ex

TMPDIR="/tmp/virt-customize"

# Prioritize networkd if it's active
# virt-customize runs in chroot, systemctl is-active doesn't work
if [ -f /etc/systemd/system/multi-user.target.wants/systemd-networkd.service ]; then
    find "$TMPDIR" -type f \( -name '*.network' -o -name '*.netdev' \) -exec install -o root -g root -m644 -t /etc/systemd/network {} \;
elif [ -d /etc/sysconfig/network-scripts ]; then
    find "$TMPDIR" -type f -name 'ifcfg-*' -exec install -o root -g root -m644 -t /etc/sysconfig/network-scripts {} \;
fi
