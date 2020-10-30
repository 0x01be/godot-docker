FROM 0x01be/xpra

RUN apk add --no-cache --virtual godot-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    godot \
    mesa \
    libx11 \
    libxcursor \
    libxinerama \
    libxi \
    libxrandr \
    libexecinfo \
    yasm \
    eudev \
    alsa-lib \
    pulseaudio \
    pulseaudio-alsa \
    alsa-plugins-pulse \
    mesa-dri-swrast

USER xpra
ENV COMMAND godot

