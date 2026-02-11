# docker build -f Dockerfile -t ghcr.io/lancerworldwide-oss/linux_vcpkg:latest .

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    '^libxcb.*-dev' \
    autoconf \
    autoconf-archive \
    automake \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    flex \
    git \
    libcurl4-openssl-dev \
    libdrm-dev \
    libegl1-mesa-dev \
    libglu1-mesa-dev \
    libiptc-dev \
    libsystemd-dev \
    libltdl-dev \
    libtool \
    libudev-dev \
    libx11-xcb-dev \
    libxi-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libxrender-dev \
    libxss-dev \
    libxtables-dev \
    ninja-build \
    pkg-config \
    python3-jinja2 \
    tar \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg \
    && /opt/vcpkg/bootstrap-vcpkg.sh -disableMetrics

ENV VCPKG_ROOT=/opt/vcpkg
ENV PATH="${VCPKG_ROOT}:${PATH}"

WORKDIR /work

# Install vcpkg deps from the manifest
COPY vcpkg.json vcpkg.json
COPY vcpkg-configuration.json vcpkg-configuration.json
RUN vcpkg install
