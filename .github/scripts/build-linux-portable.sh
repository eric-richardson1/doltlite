#!/usr/bin/env bash
# Builds and tests the Linux release binaries in a manylinux_2_28 container: a
# current gcc toolset on glibc 2.28, so the CLI tools and shared library run on
# any distribution with glibc 2.28 or newer. Binaries built on the runner's own
# image would require its much newer glibc.
#
#   build-linux-portable.sh build   configure and build into build/
#   build-linux-portable.sh test    run the native shell suites against build/
set -euo pipefail

cmd="${1:?usage: build-linux-portable.sh build|test}"
arch="$(uname -m)"
[ "$arch" = arm64 ] && arch=aarch64  # macOS names it arm64
image="${DOLTLITE_LINUX_BUILD_IMAGE:-quay.io/pypa/manylinux_2_28_$arch}"

case "$cmd" in
  build)
    script='
      mkdir -p build && cd build
      ../configure
      make -j"$(nproc)" doltlite doltlite-remotesrv doltlite-lib
    '
    ;;
  test)
    # The parity and sqlite-file suites compare against a stock SQLite built
    # from the same sources. Before glibc 2.34, dlopen lives in libdl, so the
    # suites that link libdoltlite.a themselves need -ldl. The BLAKE3
    # known-answer tests guard the hashing code against the newer compiler,
    # which warns on it.
    script='
      bash test/build_stock_reference.sh build-stock build/doltlite
      ln -sf ../build-stock/sqlite3 build/sqlite3
      PATH="$PWD/build-stock:$PATH" DOLTLITE_BUILD_DIR="$PWD/build" \
        LDFLAGS=-ldl bash test/run_doltlite_tests.sh
      (cd build && bash ../test/blake3_kat_test.sh ./doltlite)
    '
    ;;
  *)
    echo "usage: build-linux-portable.sh build|test" >&2
    exit 2
    ;;
esac

# Packages install as root; the build and tests run as the invoking user, so
# outputs keep their owner and the read-only permission tests are not bypassed
# by root.
docker run --rm \
  -v "$PWD:/src" -w /src \
  -e HOST_UID="$(id -u)" -e HOST_GID="$(id -g)" \
  "$image" bash -euo pipefail -c '
    dnf install -y -q zlib-devel tcl perl bc \
      gcc-toolset-14-libasan-devel gcc-toolset-14-libubsan-devel >/dev/null
    if [ "$HOST_UID" = 0 ]; then
      exec bash -euo pipefail -c "$1"
    fi
    groupadd -o -g "$HOST_GID" builder
    useradd -o -u "$HOST_UID" -g "$HOST_GID" -M -d /tmp builder
    exec runuser -u builder -- env PATH="$PATH" LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}" bash -euo pipefail -c "$1"
  ' bash "$script"
