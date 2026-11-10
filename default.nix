{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = config.common.username;
  tmuxBin = "${pkgs.tmux}/bin/tmux";
  adwaitaDark = {
    colors = {
      primary = {
        background = "0x1c1c1f";
        foreground = "0xffffff";
      };
      cursor = {
        cursor = "0xffffff";
        text = "0x1c1c1f";
      };
      selection = {
        background = "0xffffff";
        text = "0x1c1c1f";
      };
      normal = {
        black = "0x241f31";
        red = "0xc01c28";
        green = "0x2ec27e";
        yellow = "0xf5c211";
        blue = "0x1e78e4";
        magenta = "0x9841bb";
        cyan = "0x0ab9dc";
        white = "0xc0bfbc";
      };
      bright = {
        black = "0x5e5c64";
        red = "0xed333b";
        green = "0x57e389";
        yellow = "0xf8e45c";
        blue = "0x51a1ff";
        magenta = "0xc061cb";
        cyan = "0x4fd2fd";
        white = "0xf6f5f4";
      };
    };
  };
in
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      alacritty
      iosevka
      sarasa-gothic
    ];
    home.file.".config/fontconfig/conf.d/10-terminal-mono.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias>
          <family>monospace</family>
          <prefer>
            <family>Iosevka</family>
            <family>Sarasa Mono SC</family>
          </prefer>
        </alias>
      </fontconfig>
    '';
    programs = {
      alacritty = {
        enable = true;
        package = pkgs.alacritty;
        settings = adwaitaDark // {
          terminal = {
            shell = {
              program = tmuxBin;
              args = [
                "new-session"
                "-A"
                "-D"
                "-s"
                "ghostty"
              ];
            };
          };
          font = {
            size = 12.0;
            normal = {
              family = "Iosevka";
              style = "Regular";
            };
            bold = {
              style = "Bold";
            };
            italic = {
              style = "Italic";
            };
            bold_italic = {
              style = "Bold Italic";
            };
          };
          cursor = {
            style = {
              shape = "Block";
              blinking = "On";
            };
          };
          window.padding = {
            x = 20;
            y = 10;
          };
          window.dynamic_padding = true;
          window.title = "";
          window.dynamic_title = false;
        };
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
        exec = "alacritty";
      };
    };
  };
}
