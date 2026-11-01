# terminal

Ghostty (systemd user service, tmux on launch), tmux on local VT logins via fish (kernel `/dev/ttyN` or kmscon `/dev/pts/*` with `kmsconvt@` / `getty@tty` session), tmux config, and fish `conf.d` alt-key binds when `TMUX` is set.

Tmux uses `tmux-256color`, true-colour overrides, and `allow-passthrough off`. Focus reporting is off so fish (vi bindings, starship) does not corrupt panes when switching splits. Fish tmux workarounds live in `shell` (`46-tmux.fish`).

Home Manager + NixOS fish defaults. Requires **`./common`** only; sets `programs.fish` and login shell defaults. Import **`./shell`** as well for starship, lsd, and extra fish snippets.
