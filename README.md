# terminal

Alacritty with **Adwaita Dark** palette colours, default command attaches tmux session `ghostty`, and **Iosevka** then **Sarasa Mono SC** via profile font plus `10-terminal-mono.conf`.

Alacritty has no per-codepoint font maps; missing glyphs use Fontconfig’s `monospace` prefer list (same order as the former Kitty `symbol_map` intent). `pkgs.iosevka` and `sarasa-gothic` are on `PATH` via `home.packages`.

Shell-agnostic: tmux runs the login shell (set by `./shell` or the host). Requires **`./common`** only. Import **`./shell`** for fish, starship, and `55-tmux-alt-keys` when using fish with tmux pane keys.

Tmux uses `tmux-256color`, true-colour overrides, `allow-passthrough off`, and focus reporting off.
