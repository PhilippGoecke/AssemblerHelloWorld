podman build --no-cache --rm -f Containerfile -t asm:demo .
podman run --interactive --tty asm:demo
