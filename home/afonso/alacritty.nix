{ ... }: {
  home.sessionVariables.TERMINAL = "alacritty";

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 9.0;

        normal = {
          family = "FiraMono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "FiraMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "FiraMono Nerd Font";
          style = "Italic";
        };
        
        bold_italic = {
          family = "FiraMono Nerd Font";
          style = "Bold Italic";
        };
      };

      keyboard.bindings = [
        {
          action = "Paste";
          key = "V";
          mods = "Control|Shift";
        }
        {
          action = "Copy";
          key = "C";
          mods = "Control|Shift";
        }
        {
          action = "PasteSelection";
          key = "Insert";
          mods = "Shift";
        }
        {
          action = "ResetFontSize";
          key = "Key0";
          mods = "Control";
        }
        {
          action = "IncreaseFontSize";
          key = "Plus";
          mods = "Control";
        }
        {
          action = "DecreaseFontSize";
          key = "Minus";
          mods = "Control";
        }
        {
          action = "ClearLogNotice";
          key = "L";
          mods = "Control";
        }
        {
          chars = "\\f";
          key = "L";
          mods = "Control";
        }
        {
          action = "ScrollPageUp";
          key = "PageUp";
          mode = "~Alt";
          mods = "None";
        }
        {
          action = "ScrollPageDown";
          key = "PageDown";
          mode = "~Alt";
          mods = "None";
        }
        {
          action = "ScrollToTop";
          key = "Home";
          mode = "~Alt";
          mods = "Shift";
        }
        {
          action = "ScrollToBottom";
          key = "End";
          mode = "~Alt";
          mods = "Shift";
        }
      ];

      window = {
        dynamic_padding = true;
        opacity = 1.0;
        title = "Alacritty";

        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };

        padding = {
          x = 10;
          y = 5;
        };
      };

      env = {
        "TERM" = "xterm-256color";
      };

      # TODO: Change this to base16 colors shared with other programs
      # Theme: TokyoNight
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#a9b1d6";
        };

        normal = {
          black = "#32344a";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#ad8ee6";
          cyan = "#449dab";
          white = "#787c99";
        };

        bright = {
          black = "#444b6a";
          red = "#ff7a93";
          green = "#b9f27c";
          yellow = "#ff9e64";
          blue = "#7da6ff";
          magenta = "#bb9af7";
          cyan = "#0db9d7";
          white = "#acb0d0";
        };
      };
    };
  };
}
