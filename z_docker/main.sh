#!/bin/sh
exec docker run -it \
    --name void-c-dev \
    --security-opt no-new-privileges \
    --cap-drop ALL --cap-add DAC_OVERRIDE --cap-add CHOWN --cap-add FOWNER \
    --pids-limit 1024 --memory=8g --cpus=6 \
    --device /dev/dri \
    --dns 8.8.8.8 --dns 1.1.1.1 \
    -e XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
    --mount type=bind,source="$XDG_RUNTIME_DIR",target="$XDG_RUNTIME_DIR" \
    --mount type=bind,source="$HOME/Downloads/foot",target=/workspace \
    foot-dev:working /bin/sh
