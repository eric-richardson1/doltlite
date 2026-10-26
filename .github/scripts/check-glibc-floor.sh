#!/usr/bin/env bash
# Fails if any listed ELF file requires a glibc symbol version newer than
# MAX (default 2.28, the glibc of the manylinux_2_28 build image).
set -euo pipefail

max="${DOLTLITE_MAX_GLIBC:-2.28}"
status=0
for f in "$@"; do
  needed=$(objdump -T "$f" | grep -o 'GLIBC_[0-9.]*' | sed 's/GLIBC_//' | sort -V -u | tail -1)
  if [ -n "$needed" ] && [ "$(printf '%s\n%s\n' "$max" "$needed" | sort -V | tail -1)" != "$max" ]; then
    echo "$f requires glibc $needed, newer than $max" >&2
    status=1
  else
    echo "$f: glibc ${needed:-none} <= $max"
  fi
done
exit $status
