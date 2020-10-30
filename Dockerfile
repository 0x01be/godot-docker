FROM alpine as build

RUN apk add git &&\
    git clone --depth 1 https://github.com/Orama-Interactive/Pixelorama.git /Pixelorama &&\
    git clone --depth 1 https://github.com/godotengine/godot-demo-projects.git /Demos

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

COPY --from=build /Pixelorama/ /home/xpra/Pixelorama/
COPY --from=build /Demos/ /home/xpra/Demos/
RUN chown -R xpra:xpra /home/xpra

USER xpra

ENV COMMAND godot

