# qemu-container

Easy vm setup with kvm-qemu, containerized for portabily. No-vnc address: `host_ip:5901`

### ENV -s
>possible ENV settings:
```sh
CPU_CORE="4"
MEMORY="6144"
ISO="debian.iso"
```
### Build the container:
>docker build -t kvmqemu:01 .

### Example run command:
```sh
docker run \
    --rm \
    -it \
    --device /dev/kvm \
    -v ./iso:/root \
    -e ISO="windows.iso" \
    -e TCP_PORTS=22,80 \
    -p 2222:22 \
    -p 8080:80 \
    -p 5901:5901 \
    --name kvmqemu \
    kvmqemu:01
```