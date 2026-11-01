# terminal

Ghostty (systemd user service, default command attaches tmux session `ghostty`), tmux, and Iosevka / Sarasa Gothic fonts.

Shell-agnostic: uses the login shell inside tmux (set by `./shell` or the host). Requires **`./common`** only. Import **`./shell`** for fish, starship, and `55-tmux-alt-keys` when using fish with tmux pane keys.

Tmux uses `tmux-256color`, true-colour overrides, `allow-passthrough off`, and focus reporting off.
