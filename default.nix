{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = config.common.username;
  tmuxCmd = "${pkgs.tmux}/bin/tmux new-session -A -D -s ghostty";
  iosevkaDir = "${pkgs.iosevka}/share/fonts/truetype";
  iosevkaFace = name: "${iosevkaDir}/${name}";
  cjkSymbolMaps = [
    "U+1100-U+11FF Sarasa Gothic K"
    "U+3130-U+318F Sarasa Gothic K"
    "U+AC00-U+D7A3 Sarasa Gothic K"
    "U+D7B0-U+D7FF Sarasa Gothic K"
    "U+FFA0-U+FFDC Sarasa Gothic K"
    "U+3040-U+309F Sarasa Gothic J"
    "U+30A0-U+30FF Sarasa Gothic J"
    "U+31F0-U+31FF Sarasa Gothic J"
    "U+FF66-U+FF9F Sarasa Gothic J"
    "U+1B000-U+1B0FF Sarasa Gothic J"
    "U+3100-U+312F Sarasa Gothic TC"
    "U+31A0-U+31BF Sarasa Gothic TC"
    "U+2E80-U+2EFF Sarasa Gothic SC"
    "U+2F00-U+2FDF Sarasa Gothic SC"
    "U+2FF0-U+2FFF Sarasa Gothic SC"
    "U+3000-U+303F Sarasa Gothic SC"
    "U+31C0-U+31EF Sarasa Gothic SC"
    "U+3200-U+32FF Sarasa Gothic SC"
    "U+3300-U+33FF Sarasa Gothic SC"
    "U+3400-U+4DBF Sarasa Gothic SC"
    "U+4E00-U+9FFF Sarasa Gothic SC"
    "U+F900-U+FAFF Sarasa Gothic SC"
    "U+FE30-U+FE4F Sarasa Gothic SC"
    "U+FF00-U+FF65 Sarasa Gothic SC"
    "U+FFDD-U+FFEF Sarasa Gothic SC"
    "U+20000-U+2A6DF Sarasa Gothic SC"
    "U+2A700-U+2B73F Sarasa Gothic SC"
    "U+2B740-U+2B81F Sarasa Gothic SC"
    "U+2B820-U+2CEAF Sarasa Gothic SC"
    "U+2CEB0-U+2EBEF Sarasa Gothic SC"
    "U+30000-U+3134F Sarasa Gothic SC"
  ];
in
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      iosevka
      sarasa-gothic
    ];
    home.file.".config/kitty/tmux.session".text = "launch ${tmuxCmd}\n";
    programs = {
      kitty = {
        enable = true;
        package = pkgs.kitty;
        themeFile = "adwaita_dark";
        shellIntegration = {
          mode = "disabled";
          enableBashIntegration = false;
          enableFishIntegration = false;
          enableZshIntegration = false;
        };
        settings = {
          hide_window_decorations = "no";
          linux_display_server = "wayland";
          wayland_titlebar_color = "#1d1d20";
          window_margin_width = 10;
          font_size = 11;
          confirm_os_window_close = -1;
          cursor_blink_interval = 0.5;
        };
        extraConfig = ''
          font_family ${iosevkaFace "Iosevka-Medium.ttf"}
          bold_font ${iosevkaFace "Iosevka-Bold.ttf"}
          italic_font ${iosevkaFace "Iosevka-Italic.ttf"}
          bold_italic_font ${iosevkaFace "Iosevka-BoldItalic.ttf"}
          startup_session tmux.session
        ''
        + (builtins.concatStringsSep "\n" (map (line: "symbol_map ${line}") cjkSymbolMaps))
        + "\n";
      };
      tmux = {
        enable = true;
        escapeTime = 0;
        terminal = "tmux-256color";
        focusEvents = false;
        extraConfig = ''
          unbind -a
          set -g cursor-style blinking-block
          set -g mode-keys vi
          set -g mode-style 'reverse'
          set -g prefix None
          set -s set-clipboard external
          set -g status off
          set -g status-keys emacs
          set -g allow-passthrough off
          setw -g aggressive-resize on
          set -as terminal-features ',*:RGB'
          set -as terminal-overrides ',tmux-256color:RGB:Tc'
          set -s extended-keys on
          set -s extended-keys-format xterm
          set -g user-keys on

          bind -n M-Escape copy-mode
          bind -n M-Enter run "tmux setenv PREVIOUS_DIR '#{pane_current_path}'; [[ $(($(tmux display -p '8*#{pane_width}-20*#{pane_height}'))) -lt 0 ]] \
                               && tmux splitw -v \
                               || tmux splitw -h" 

          bind -T copy-mode-vi M-Escape send -X cancel
          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi C-v send-keys -X rectangle-toggle \; send -X begin-selection
          bind -T copy-mode-vi y send -X copy-pipe
          bind -T copy-mode-vi M-Left select-pane -L 
          bind -T copy-mode-vi M-Down select-pane -D 
          bind -T copy-mode-vi M-Up select-pane -U   
          bind -T copy-mode-vi M-Right select-pane -R

          bind-key -n 'M-Left' if-shell -F '#{@vim}' 'send-keys M-Left' 'select-pane -L'
          bind-key -n 'M-Down' if-shell -F '#{@vim}' 'send-keys M-Down' 'select-pane -D'
          bind-key -n 'M-Up' if-shell -F '#{@vim}' 'send-keys M-Up' 'select-pane -U'
          bind-key -n 'M-Right' if-shell -F '#{@vim}' 'send-keys M-Right' 'select-pane -R'
        '';
      };
    };
    dconf.settings = {
      "org/gnome/desktop/default-applications/terminal" = {
        exec = "kitty";
      };
    };
    home.activation.refreshFontconfigCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.fontconfig}/bin/fc-cache -r
    '';
  };
}
