# terminal

Kitty (Wayland, `adwaita_dark` theme, client-side window decorations), default session attaches tmux `ghostty`, and Iosevka / Sarasa Gothic fonts.

**Iosevka** is the primary font (store paths in `kitty.conf` so Fontconfig cache drift does not break startup). CJK codepoints use **symbol_map** to Sarasa Gothic SC, J, K, and TC (same ranges as the former Ghostty maps). `window_margin_width` replaces Ghostty outer padding. Config reload: `kill -SIGUSR1 $(pidof kitty)` or restart Kitty.

Shell-agnostic: uses the login shell inside tmux (set by `./shell` or the host). Requires **`./common`** only. Import **`./shell`** for fish, starship, and `55-tmux-alt-keys` when using fish with tmux pane keys.

Tmux uses `tmux-256color`, true-colour overrides, `allow-passthrough off`, and focus reporting off.
