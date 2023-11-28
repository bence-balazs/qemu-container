#!/bin/sh

# Qemu start script
qemu_start() {
    local VM_CORE=${1}
    local VM_MEMORY=${2}
    local VM_ISO=${3}
    qemu-system-x86_64 \
            -enable-kvm \
            -cpu "host,migratable=on,hv-time=on,hv-relaxed=on,hv-vapic=on,hv-spinlocks=0x1fff,hv-vpindex=on,hv-synic=on,hv-stimer=on,hv-reset=on"\
            -smp "sockets=1,cores=${VM_CORE},threads=1,dies=1" \
            -boot d \
            -m "${VM_MEMORY}" \
            -mem-prealloc \
            -overcommit mem-lock=off \
            -no-user-config \
            -net nic,model=virtio -net user \
            -drive "if=scsi,driver=raw,file=/root/disk.img,index=2" \
            -drive file="/root/${VM_ISO}",media=cdrom,index=1 \
            -rtc base=localtime,clock=host \
            -usb -device usb-tablet \
            -display none \
            -vnc :0
}
