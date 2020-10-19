FROM alpine as build

RUN apk add --no-cache --virtual godot-build-dependencies \
    git \
    build-base \
    cmake \
    pkgconfig \
    scons \
    mesa-dev \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxi-dev \
    libxrandr-dev \
    libexecinfo-dev \
    yasm-dev \
    linux-headers \
    eudev-dev \
    alsa-lib-dev \
    pulseaudio-dev \
    pulseaudio-alsa \
    alsa-plugins-pulse

ENV GODOT_REVISION master
RUN git clone --depth 1 --branch ${GODOT_REVISION} https://github.com/godotengine/godot.git /godot

WORKDIR /godot

RUN apk add libexecinfo-dev
RUN sed -i.bak 's/size_t size = backtrace.*/size_t size = 0;/g' /godot/platform/linuxbsd/crash_handler_linuxbsd.cpp
RUN sed -i.bak 's/.*backtrace_symbols/char **strings = NULL;/g' /godot/platform/linuxbsd/crash_handler_linuxbsd.cpp
RUN scons platform=linuxbsd

