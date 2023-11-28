#!/bin/sh

docker run \
    --rm \
    -it \
    --device /dev/kvm \
    -v ./iso:/root \
    -e ISO="win.iso" \
    -e TCP_PORTS=22,80 \
    -p 2222:22 \
    -p 8080:80 \
    -p 5901:5901 \
    --name kvmqemu \
    kvmqemu:01
