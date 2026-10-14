function __terminal_want_tmux_bootstrap -d "Local VT login (kernel tty or kmscon), not SSH or GUI"
  if set -q SSH_CONNECTION SSH_CLIENT
    return 1
  end
  if set -q WAYLAND_DISPLAY DISPLAY
    return 1
  end
  set -l login_tty (tty)
  if string match -qr '^/dev/tty[0-9]+$' $login_tty
    return 0
  end
  if not string match -qr '^/dev/pts/' $login_tty
    return 1
  end
  if set -q XDG_SESSION_ID
    set -l svc (loginctl show-session "$XDG_SESSION_ID" -p Service --value 2>/dev/null)
    if string match -qr 'kmscon|getty@tty' $svc
      return 0
    end
  end
  return 1
end

if status is-interactive
  if not set -q TMUX
    if __terminal_want_tmux_bootstrap
      exec tmux new-session -A -D -s ghostty
    end
  end
end
