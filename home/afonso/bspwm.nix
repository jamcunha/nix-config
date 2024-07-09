{ pkgs, ... }: let
  bspwm-change-workspace = pkgs.writeShellScriptBin "bspwm-change-workspace" ''
    monitor=$(${pkgs.bspwm}/bin/bspc query -M -m focused --names)

    ${pkgs.bspwm}/bin/bspc desktop $monitor:^$1 -f
  '';

  bspwm-move-workspace = pkgs.writeShellScriptBin "bspwm-move-workspace" ''
    monitor=$(${pkgs.bspwm}/bin/bspc query -M -m focused --names)

    ${pkgs.bspwm}/bin/bspc node -d $monitor:^$1
  '';

  bspwm-scratchterm = pkgs.writeShellScriptBin "bspwm-scratchterm" ''
    winclass="$(${pkgs.xdotool}/bin/xdotool search --class scratchterm)"

    if [ -z "$winclass" ]; then
        ${pkgs.alacritty}/bin/alacritty --class scratchterm
    else
        if [ ! -f /tmp/scratchterm ]; then
            touch /tmp/scratchterm && ${pkgs.xdo}/bin/xdo hide "$winclass"
        elif [ -f /tmp/scratchterm ]; then
            rm /tmp/scratchterm && ${pkgs.xdo}/bin/xdo show "$winclass"
        fi
    fi
  '';
in {
  home.packages = [
    bspwm-change-workspace
    bspwm-move-workspace
    bspwm-scratchterm
  ];

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      HDMI-2 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];

      # when nvidia is enabled
      eDP-1-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      HDMI-1-2 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    };

    rules = {
      "matplotlib" = {
        state = "floating";
      };

      "discord" = {
        desktop = "^8";
        focus = false;
      };

      "scratchterm" = {
        sticky = true;
        state = "floating";
        rectangle = "1000x600+475+250";
      };
    };

    settings = {
      border_width = 2;
      window_gap = 3;

      pointer_modifier = "mod1";

      split_ratio = 0.50;
      borderless_monocle = true;
      gapless_monocle = true;

      # TODO: Change this to base16
      normal_border_color = "#1a1b26";
      active_border_color = "#1a1b26";
      focused_border_color = "#7aa2f7";
    };

    extraConfig = ''
      killall dunst polybar picom

      picom &
      nitrogen --restore &
      dunst &
      $HOME/.config/polybar/launch.sh &
    '';
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return"                = "${pkgs.alacritty}/bin/alacritty";
      "super + p"                     = "${pkgs.rofi}/bin/rofi -show drun";
      "super + {b,shift + b}"         = "{${pkgs.firefox}/bin/firefox, ${pkgs.firefox}/bin/firefox --private-window}";
      "super + f"                     = "${pkgs.xfce.thunar}/bin/thunar";
      "super + shift + s"             = "${pkgs.flameshot}/bin/flameshot gui";
      "super + shift + Return"        = "${bspwm-scratchterm}/bin/bspwm-scratchterm";

      "XF86AudioRaiseVolume"          = "${pkgs.alsa-utils}/bin/amixer sset Master 1%+";
      "XF86AudioLowerVolume"          = "${pkgs.alsa-utils}/bin/amixer sset Master 1%-";
      "XF86AudioMute"                 = "${pkgs.alsa-utils}/bin/amixer sset Master toggle";
      "XF86AudioPlay"                 = "${pkgs.playerctl}/bin/playerctl play-pause";
      "XF86AudioNext"                 = "${pkgs.playerctl}/bin/playerctl next";
      "XF86AudioPrev"                 = "${pkgs.playerctl}/bin/playerctl previous";
      "XF86AudioStop"                 = "${pkgs.playerctl}/bin/playerctl stop";
      "super + m; {N,n,p}"            = "${pkgs.playerctl}/bin/playerctl {previous,next,play-pause}";

      "super + shift + r"             = "${pkgs.bspwm}/bin/bspc wm -r";
      "super + shift + q"             = "$HOME/.config/rofi/powermenu/powermenu.sh"; # TODO: Add a script in nix for this
      "super + shift + c"             = "${pkgs.bspwm}/bin/bspc node -c";
      "super + y"                     = "${pkgs.bspwm}/bin/bspc node -s biggest.window";
      "super + {t,shift + t}"         = "${pkgs.bspwm}/bin/bspc node -t {tiled,pseudo_tiled}";
      "super + shift + @space"        = "${pkgs.bspwm}/bin/bspc node -t floating";
      "super + shift + f"             = "${pkgs.bspwm}/bin/bspc node -t fullscreen";
      "super + {_,shift + }{h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";
      "super + {1-9,0}"               = "${bspwm-change-workspace}/bin/bspwm-change-workspace {1-9,10}";
      "super + shift + {1-9,0}"       = "${bspwm-move-workspace}/bin/bspwm-move-workspace {1-9,10}";
      "super + ctrl + {h,j,k,l}"      = "${pkgs.bspwm}/bin/bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + {Left, Right}"         = "${pkgs.bspwm}/bin/bspc monitor -f {prev,next}";
    };
  };
}
