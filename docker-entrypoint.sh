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

echo "Starting qemu..."
qemu_start ${CPU_CORE} ${MEMORY} ${ISO}
