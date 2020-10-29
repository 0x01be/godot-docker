FROM 0x01be/godot:build as build

FROM 0x01be/xpra

USER root
RUN apk add --no-cache --virtual godot-runtime-dependencies \
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

COPY --from=build /godot/bin/godot.linuxbsd.tools.64 /opt/godot/bin/godot

RUN apk add git
RUN git clone --depth 1 https://github.com/Orama-Interactive/Pixelorama.git /home/xpra/Pixelorama
RUN git clone --depth 1 https://github.com/godotengine/godot-demo-projects.git /home/xpra/Demos
RUN mkdir -p /home/xpra/.config/pulse
RUN chown -R xpra:xpra /home/xpra

USER xpra

ENV COMMAND godot

