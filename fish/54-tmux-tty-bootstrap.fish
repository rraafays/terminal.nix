if status is-interactive
  if not set -q TMUX
    set -l kmscon_tty (tty)
    if string match -qr '^/dev/tty' $kmscon_tty
      exec tmux new-session -A -D -s ghostty
    end
  end
end
