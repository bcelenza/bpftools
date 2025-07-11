# BPF Tools

## Docker Image

Usage:
1. Install appropriate kernel headers on the host (e.g., `apt install linux-headers-$(uname -r)`)
2. Run the image:

```sh
sudo docker run -it --rm --privileged \
    -v /lib/modules:/lib/modules:ro \
    -v /sys/kernel/debug:/sys/kernel/debug:ro \
    -v /usr/src:/usr/src:ro \
    bcelenza/bpftools
```