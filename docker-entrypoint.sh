#!/bin/sh
source /opt/functions.sh

set -e
echo "container starting..."

# Set KVM node
if ! [ -c /dev/kvm ]; then
    echo "kvm node does not exist"
    mknod /dev/kvm c 10 232
fi

if ! [ -f "/root/disk.img" ]; then
    echo "creating disk.img..."
    qemu-img create -f "raw" "/root/disk.img" "35G"
fi

echo "Startin novnc..."
/easy-novnc &

# qemu flags
INSTALL_CD="-drive file=/root/win.iso,media=cdrom,index=1 "
REBOOT_OFF="-no-reboot "

# Start qemu with cd inserted and with -no-reboot
if [ ${BOOT_FROM_CD} == 1 ]; then
    echo "CD - Starting qemu with CD inserted"
    qemu_start ${CPU_CORE} ${MEMORY} "${INSTALL_CD}" "${REBOOT_OFF}"
fi
BOOT_FROM_CD=0

# Start qemu without CD
echo "NO CD - Starting qemu without CD inserted"
qemu_start ${CPU_CORE} ${MEMORY}
