# terminal

Ghostty (systemd user service, tmux on launch), tmux on local VT logins via fish (kernel `/dev/ttyN` or kmscon `/dev/pts/*` with `loginctl Type=tty`), tmux config, and fish `conf.d` alt-key binds when `TMUX` is set.

kmscon does not implement OSC 52, so tmux copy mode pipes yanks to `wl-copy` when a Wayland socket exists under `/run/user/$UID` (GNOME can stay on another VT). Fish sets `WAYLAND_DISPLAY` before tmux starts on VT logins. Neovim `clipboard=unnamedplus` uses the same tools when `wl-clipboard` is on PATH.

Home Manager only. Requires `./common` and fish (import `./shell` or enable fish elsewhere). Importer must define `users.users.<common.username>`.
