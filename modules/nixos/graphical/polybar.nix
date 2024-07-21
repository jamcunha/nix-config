{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (pkgs.stdenv.isLinux && config.services.xserver.enable) {
    home-manager.users.${config.user} = {
      services.polybar = {
        enable = true;
        package = pkgs.polybar.override {
          pulseSupport = true;
        };

        script = ''
          # Terminate already running bar instances
          # If all your bars have ipc enabled, you can use 
          polybar-msg cmd quit
          # Otherwise you can use the nuclear option:
          # killall -q polybar
          
          # Launch bar1
          echo "---" | tee -a /tmp/polybar.log

          for m in $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f3 | cut -d"+" -f2 | cut -d"*" -f2); do
            echo "$m"
            MONITOR=$m polybar main 2>&1 | tee -a /tmp/polybar.log & disown
          done

          echo "Bars launched..."
        '';

        # TODO: change colors to base16
        config = {
          "bar/main" = {
            monitor = "\${env:MONITOR:}";
            width = "100%";
            height = 30;
            radius = 0;
            fixed-center = true;
            bottom = false;

            foreground = "#cfc9c2";
            background = "#1a1b26";
            border-size = 0;

            font-0 = "JetBrainsMono Nerd Font:size=12;2";
            font-1 = "Font Awesome 6 Free Solid:size=12;2";

            modules-left = "workspaces";
            # modules-center = "";
            modules-right = "network battery pulseaudio date powermenu";

            cursor-click = "pointer";
            cursor-scroll = "ns-resize";

            enable-ipc = true;

            tray-position = "center";

            wm-restack = "bspwm";
          };

          "settings" = {
            screencharge-reload = true;
            pseudo-transparency = true;
          };

          "module/workspaces" = {
            type = "internal/xworkspaces";

            pin-workspaces = true;

            label-active = "%name%";
            label-active-foreground = "#cfc9c2";
            label-active-background = "#7aa2f7";

            label-occupied = "%name%";
            label-occupied-foreground = "#cfc9c2";
            label-occupied-background = "#565f89";

            label-urgent = "%name%";
            label-urgent-foreground = "#e0af68";
            label-urgent-background = "#f7768e";

            label-empty = "%name%";
            label-empty-foreground = "#cfc9c2";
            label-empty-background = "#1a1b26";

            label-active-padding = 1;
            label-occupied-padding = 1;
            label-urgent-padding = 1;
            label-empty-padding = 1;
          };

          "module/pulseaudio" = {
            type = "internal/pulseaudio";

            ramp-volume-0 = "";
            ramp-volume-1 = "";
            ramp-volume-2 = "";
            ramp-volume-font = 2;
            ramp-volume-foreground = "#cfc9c2";
            ramp-volume-background = "#9ece6a";
            ramp-volume-padding = 1;

            label-volume = "%percentage%%";
            label-volume-background = "#1a1b26";
            label-volume-foreground = "#cfc9c2";
            label-volume-padding = 1;

            format-volume = "<ramp-volume><label-volume>";

            format-muted-prefix = "";
            format-muted-prefix-font = 2;
            format-muted-foreground = "#cfc9c2";
            format-muted-prefix-background = "#9ece6a";
            format-muted-prefix-padding = 1;

            label-muted = "muted";
            label-muted-foreground = "#1a1b26";
            label-muted-background = "#cfc9c2";
            label-muted-padding = 1;

            format-muted = "<label-muted>";
          };

          "module/date" = {
            type = "internal/date";
            interval = 5;

            time = "%k:%M";
            time-alt = "%A, %d %B %k:%M";

            format-prefix = "";
            format-prefix-font = 2;
            format-prefix-foreground = "#cfc9c2";
            format-prefix-background = "#bb9af7";
            format-prefix-padding = 1;

            label = "%time%";
            label-foreground = "#cfc9c2";
            label-background = "#1a1b26";
            label-padding = 1;

            format = "<label>";
          };

          "module/battery" = {
            type = "internal/battery";

            battery = "BAT1";
            adapter = "ADP1";

            time-format = "%H:%M";

            animation-charging-0 = " ";
            animation-charging-1 = " ";
            animation-charging-2 = " ";
            animation-charging-3 = " ";
            animation-charging-4 = " ";
            animation-charging-font = 2;
            animation-charging-foreground = "#cfc9c2";
            animation-charging-background = "#ff9e64";
            animation-charging-padding = 1;
            animation-charging-framerate = 750;

            label-charging = "%percentage%% (%time%)";
            label-charging-padding = 1;

            format-charging = "<animation-charging><label-charging>";

            ramp-capacity-0 = "";
            ramp-capacity-1 = "";
            ramp-capacity-2 = "";
            ramp-capacity-3 = "";
            ramp-capacity-4 = "";
            ramp-capacity-font = 2;
            ramp-capacity-foreground = "#cfc9c2";
            ramp-capacity-background = "#ff9e64";
            ramp-capacity-padding = 1;

            label-discharging = "%percentage%% (%time%)";
            label-discharging-padding = 1;

            format-discharging = "<ramp-capacity><label-discharging>";

            format-full-prefix = "";
            format-full-prefix-font = 2;
            format-full-prefix-foreground = "#cfc9c2";
            format-full-prefix-background = "ff9e64";
            format-full-prefix-padding = 1;

            label-full = "%percentage%%";
            label-full-padding = 1;

            format-full = "<label-full>";

            format-low-prefix = " ";
            format-low-prefix-font = 2;
            format-low-prefix-foreground = "#cfc9c2";
            format-low-prefix-background = "#f7768e";
            format-low-prefix-padding = 1;

            label-low = "%percentage%% (%time%)";
            label-low-padding = 1;

            format-low = "<label-low>";
          };

          "module/powermenu" = {
            type = "custom/text";

            content = "";
            content-font = 2;
            content-foreground = "#cfc9c2";
            content-background = "#f7768e";
            content-padding = 1;

            click-left = "${config.gui.powermenuCmd} &";
          };

          "module/network" = {
            type = "internal/network";
            interface = "wlo1";

            interval = "1.0";

            format-connected-prefix = "";
            format-connected-prefix-font = 2;
            format-connected-prefix-foreground = "#cfc9c2";
            format-connected-prefix-background = "#7dcfff";
            format-connected-prefix-padding = 1;

            label-connected = "%essid%";
            label-connected-padding = 1;

            format-connected = "<label-connected>";

            format-disconnected-prefix = "";
            format-disconnected-prefix-font = 2;
            format-disconnected-prefix-foreground = "#cfc9c2";
            format-disconnected-prefix-background = "#7dcfff";
            format-disconnected-prefix-padding = 1;

            label-disconnected = "Wifi Off";
            label-disconnected-padding = 1;

            format-disconnected = "<label-disconnected>";
          };
        };
      };
    };
  };
}
