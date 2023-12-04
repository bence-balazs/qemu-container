#!/bin/sh

# Qemu start script
qemu_start() {
    local VM_CORE=${1}
    local VM_MEMORY=${2}
    local VM_ISO=${3}
    local VM_REBOOT_FLAG=${4}
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
            -drive "if=ide,driver=raw,file=/root/disk.img,index=2" \
            ${VM_ISO} \
            -rtc base=localtime,clock=host \
            -usb -device usb-tablet \
            -display none \
            ${VM_REBOOT_FLAG} \
            -vnc :0
}
