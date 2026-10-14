if status is-interactive
  if not set -q XDG_RUNTIME_DIR
    set -gx XDG_RUNTIME_DIR "/run/user"(id -u)
  end
  if test -z "$WAYLAND_DISPLAY"
    for sock in wayland-1 wayland-0
      if test -S "$XDG_RUNTIME_DIR/$sock"
        set -gx WAYLAND_DISPLAY $sock
        break
      end
    end
  end
end
