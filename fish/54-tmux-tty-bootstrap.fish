if status is-interactive
  if not set -q TMUX
    set -l login_tty (tty)
    if string match -qr '^/dev/tty' $login_tty
      exec tmux new-session -A -D -s ghostty
    end
  end
end
