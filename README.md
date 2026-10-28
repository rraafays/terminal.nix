# terminal

Ghostty (systemd user service, tmux on launch), tmux on local VT logins via fish (kernel `/dev/ttyN` or kmscon `/dev/pts/*` with `kmsconvt@` / `getty@tty` session), tmux config, and fish `conf.d` alt-key binds when `TMUX` is set.

Home Manager + NixOS fish defaults. Requires **`./common`** only; sets `programs.fish` and login shell defaults. Import **`./shell`** as well for starship, lsd, and extra fish snippets.
