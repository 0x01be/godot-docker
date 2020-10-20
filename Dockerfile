FROM 0x01be/godot:build as build

FROM 0x01be/xpra

COPY --from=build /godot/bin/godot.linuxbsd.tools.64 /opt/godot/bin/godot

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

RUN mkdir -p /tmp/.X11-unix
RUN chmod 1777 /tmp/.X11-unix

RUN apk add git
RUN git clone --depth 1 https://github.com/Orama-Interactive/Pixelorama.git /home/xpra/Pixelorama
RUN mkdir -p /home/xpra/.config/pulse
RUN chown -R xpra:xpra /home/xpra

WORKDIR /home/xpra

USER xpra

ENV COMMAND godot

CMD /usr/bin/xpra start --bind-tcp=0.0.0.0:10000 --html=on --start="$COMMAND" --daemon=no --xvfb="/usr/bin/Xvfb -ac +extension Composite +extension GLX +render -screen :0     1280x720x24+32 -nolisten tcp -noreset -shmem" --pulseaudio=no --notifications=no --bell=no --mdns=no --webcam=no --global-menus=no --speaker=off --ssl=off
