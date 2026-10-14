# terminal

Ghostty (systemd user service, tmux on launch), tmux on local VT logins via fish (kernel `/dev/ttyN` or kmscon `/dev/pts/*` with `kmsconvt@` / `getty@tty` session), tmux config, and fish `conf.d` alt-key binds when `TMUX` is set.

Home Manager only. Requires `./common` and fish (import `./shell` or enable fish elsewhere). Importer must define `users.users.<common.username>`.
