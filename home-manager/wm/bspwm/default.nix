{pkgs, ...}: let
  bspwm-change-workspace = pkgs.writeShellScriptBin "bspwm-change-workspace" ''
    monitor=$(bspc query -M -m focused --names)

    bspc desktop $monitor:^$1 -f
  '';

  bspwm-move-workspace = pkgs.writeShellScriptBin "bspwm-move-workspace" ''
    monitor=$(bspc query -M -m focused --names)

    bspc node -d $monitor:^$1
  '';

  bspwm-scratchterm = pkgs.writeShellScriptBin "bspwm-scratchterm" ''
    winclass="$(xdotool search --class scratchterm)"

    if [ -z "$winclass" ]; then
        alacritty --class scratchterm
    else
        if [ ! -f /tmp/scratchterm ]; then
            touch /tmp/scratchterm && xdo hide "$winclass"
        elif [ -f /tmp/scratchterm ]; then
            rm /tmp/scratchterm && xdo show "$winclass"
        fi
    fi
  '';
in {
  imports = [
    ../x11.nix

    ./launcher/rofi.nix
    ./notification/dunst.nix
    ./status-bar/polybar.nix
  ];

  home.packages = with pkgs; [
    feh
    scrot
    xfce.thunar
    pamixer
    playerctl
    pavucontrol

    xdo
    xdotool
  ];

  services.playerctld.enable = true;

  xsession.windowManager.bspwm = {
    enable = true;

    # Find a way to make the monitors dynamic
    monitors = {
      eDP-1 = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
      HDMI-2 = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];

      # when (only) nvidia is enabled (laptop specific, still need to find a better way)
      # eDP-1-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
      # HDMI-1-2 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    };

    rules = {
      "matplotlib" = {
        state = "floating";
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

      split_ratio = 0.5;
      borderless_monocle = true;
      gapless_monocle = true;

      # TODO: Change this to base16
      normal_border_color = "#1a1b26";
      active_border_color = "#1a1b26";
      focused_border_color = "#7aa2f7";
    };

    extraConfig = ''
      ${pkgs.feh}/bin/feh --bg-fill $HOME/.wallpapers/image.png &
      systemctl --user restart polybar &
    '';
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "alacritty";
      "super + p" = "rofi -show drun";
      "super + {b,shift + b}" = "{firefox, firefox --private-window}";
      "super + f" = "thunar";
      "super + shift + s" = "scrot -s -f -z -e 'xclip -selection clipboard -t image/png -i $f && rm $f'";
      "super + shift + Return" = "${bspwm-scratchterm}/bin/bspwm-scratchterm";

      "super + shift + r" = "bspc wm -r";

      "super + shift + q" = "rofi-powermenu";
      "super + shift + c" = "bspc node -c";
      "super + y" = "bspc node -s biggest.window";
      "super + {t,shift + t}" = "bspc node -t {tiled,pseudo_tiled}";
      "super + shift + @space" = "bspc node -t floating";
      "super + shift + f" = "bspc node -t fullscreen";
      "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
      "super + {1-9,0}" = "${bspwm-change-workspace}/bin/bspwm-change-workspace {1-9,10}";
      "super + shift + {1-9,0}" = "${bspwm-move-workspace}/bin/bspwm-move-workspace {1-9,10}";
      "super + ctrl + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + {Left, Right}" = "bspc monitor -f {prev,next}";

      "XF86AudioRaiseVolume" = "pamixer -i 1";
      "XF86AudioLowerVolume" = "pamixer -d 1";
      "XF86AudioMute" = "pamixer -t";

      "XF86AudioPlay" = "playerctl --player=%any,firefox play-pause";
      "XF86AudioNext" = "playerctl --player=%any,firefox next";
      "XF86AudioPrev" = "playerctl --player=%any,firefox previous";
      "XF86AudioStop" = "playerctl --player=%any,firefox stop";
      "super + m; {N,n,p}" = "playerctl --player=%any,firefox {previous,next,play-pause}";
    };
  };
}
