#!/usr/bin/env bash
set -euo pipefail
data=$(cat)
uid=$(id -u)
runtime="${XDG_RUNTIME_DIR:-/run/user/$uid}"
if command -v wl-copy >/dev/null 2>&1; then
  export XDG_RUNTIME_DIR="$runtime"
  if [ -z "${WAYLAND_DISPLAY:-}" ]; then
    for sock in wayland-1 wayland-0; do
      if [ -S "$runtime/$sock" ]; then
        export WAYLAND_DISPLAY="$sock"
        break
      fi
    done
  fi
  if [ -n "${WAYLAND_DISPLAY:-}" ]; then
    printf '%s' "$data" | wl-copy -n --type text/plain 2>/dev/null && exit 0
  fi
fi
exit 0
