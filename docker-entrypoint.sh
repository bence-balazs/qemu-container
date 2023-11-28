#!/bin/sh
source /opt/functions.sh

set -e
echo "start..."

# Set KVM node
if ! [ -c /dev/kvm ]; then
    echo "kvm node does not exist"
    mknod /dev/kvm c 10 232
fi

qemu-img create -o preallocation=full -f "raw" "disk.img" "35G"

/easy-novnc &

qemu_start ${CPU_CORE} ${MEMORY} ${ISO}
