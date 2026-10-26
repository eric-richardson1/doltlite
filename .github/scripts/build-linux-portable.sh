#!/usr/bin/env bash
# Builds the Linux release binaries inside Ubuntu 20.04, so the CLI tools and
# shared library need at most glibc 2.31 and run on older distributions. The
# runner's own image is newer: binaries built there require its newer glibc.
set -euo pipefail

image="${DOLTLITE_LINUX_BUILD_IMAGE:-ubuntu:20.04}"

docker run --rm \
  -v "$PWD:/src" -w /src \
  -e DEBIAN_FRONTEND=noninteractive \
  -e HOST_UID="$(id -u)" -e HOST_GID="$(id -g)" \
  "$image" bash -euo pipefail -c '
    apt-get update -qq
    apt-get install -y -qq build-essential zlib1g-dev tcl >/dev/null
    mkdir -p build && cd build
    ../configure
    make -j"$(nproc)" doltlite doltlite-remotesrv doltlite-lib
    chown -R "$HOST_UID:$HOST_GID" /src/build
  '
