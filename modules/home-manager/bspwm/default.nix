{ config, pkgs, ... }: let
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

  rofi = config.programs.rofi.finalPackage;

  powermenuScript = pkgs.writeShellScriptBin "rofi-powermenu" ''
    # CMDs
    uptime="`${pkgs.procps}/bin/uptime -p | sed -e 's/up //g'`"
    host=`hostname`

    # Options
    shutdown=''
    reboot=''
    logout=''
    suspend=''
    lock=''
    yes=''
    no=''

    # Rofi CMD
    rofi_cmd() {
      ${rofi}/bin/rofi -dmenu \
        -p "Uptime: $uptime" \
        -mesg "Uptime: $uptime" \
        -theme $HOME/.config/rofi/powermenu.rasi
    }

    # Confirmation CMD
    confirm_cmd() {
      ${rofi}/bin/rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme $HOME/.config/rofi/powermenu.rasi
    }

    # Ask for confirmation
    confirm_exit() {
      echo -e "$yes\n$no" | confirm_cmd
    }

    # Pass variables to rofi dmenu
    run_rofi() {
      echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
    }

    # Execute Command
    run_cmd() {
      selected="$(confirm_exit)"
      if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
          systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
          systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
          ${pkgs.pamixer}/bin/pamixer --mute
          systemctl suspend
        elif [[ $1 == '--logout' ]]; then
          # For now only bspwm is supported. Maybe add a global logoutCmd set in wm .nix?
          bspc quit
        fi
      else
        exit 0
      fi
    }

    # Actions
    chosen="$(run_rofi)"
    case $chosen in
      $shutdown)
        run_cmd --shutdown
        ;;
      $reboot)
        run_cmd --reboot
        ;;
      $lock)
        # lock not in use but the option is there if wanted
        ;;
      $suspend)
        run_cmd --suspend
        ;;
      $logout)
        run_cmd --logout
        ;;
    esac
  '';
in {
  imports = [
    ./dunst.nix
    ./polybar.nix
    ./rofi.nix
  ];

  xsession = {
    enable = true;

    windowManager.bspwm = {
      enable = true;

      # TODO: Find a way to make monitors dynamic
      monitors = {
        eDP-1 = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "10"
        ];

        HDMI-2 = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "10"
        ];
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

      # polybar line may not be needed
      extraConfig = ''
        nitrogen --restore &
        systemctl --user start polybar
      '';
    };
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "${pkgs.alacritty}/bin/alacritty";

      "super + p" = "${rofi}/bin/rofi -show drun";

      "super + {b,shift + b}" = "{${pkgs.firefox}/bin/firefox, ${pkgs.firefox}/bin/firefox --private-window}";
      "super + f" = "${pkgs.xfce.thunar}/bin/thunar";
      "super + shift + s" = "${pkgs.scrot}/bin/scrot -s -f -z -e '${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i $f && rm $f'";
      "super + shift + Return" = "${bspwm-scratchterm}/bin/bspwm-scratchterm";

      "super + shift + r" = "${pkgs.bspwm}/bin/bspc wm -r";

      "super + shift + q" = "${powermenuScript}/bin/rofi-powermenu";

      "super + shift + c" = "${pkgs.bspwm}/bin/bspc node -c";
      "super + y" = "${pkgs.bspwm}/bin/bspc node -s biggest.window";
      "super + {t,shift + t}" = "${pkgs.bspwm}/bin/bspc node -t {tiled,pseudo_tiled}";
      "super + shift + @space" = "${pkgs.bspwm}/bin/bspc node -t floating";
      "super + shift + f" = "${pkgs.bspwm}/bin/bspc node -t fullscreen";
      "super + {_,shift + }{h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";
      "super + {1-9,0}" = "${bspwm-change-workspace}/bin/bspwm-change-workspace {1-9,10}";
      "super + shift + {1-9,0}" = "${bspwm-move-workspace}/bin/bspwm-move-workspace {1-9,10}";
      "super + ctrl + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + {Left, Right}" = "${pkgs.bspwm}/bin/bspc monitor -f {prev,next}";

      "XF86AudioRaiseVolume" = "${pkgs.pamixer}/bin/pamixer -i 1";
      "XF86AudioLowerVolume" = "${pkgs.pamixer}/bin/pamixer -d 1";
      "XF86AudioMute" = "${pkgs.pamixer}/bin/pamixer -t";

      "XF86AudioPlay" = "${pkgs.playerctl}/bin/playerctl --player=%any,firefox play-pause";
      "XF86AudioNext" = "${pkgs.playerctl}/bin/playerctl --player=%any,firefox next";
      "XF86AudioPrev" = "${pkgs.playerctl}/bin/playerctl --player=%any,firefox previous";
      "XF86AudioStop" = "${pkgs.playerctl}/bin/playerctl --player=%any,firefox stop";
      "super + m; {N,n,p}" = "${pkgs.playerctl}/bin/playerctl --player=%any,firefox {previous,next,play-pause}";
    };
  };
}
