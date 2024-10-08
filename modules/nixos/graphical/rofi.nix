{
  config,
  lib,
  pkgs,
  ...
}:
let
  rofi = config.home-manager.users.${config.user}.programs.rofi.finalPackage;

  # TODO: add base16 colors
  powermenuRasi = pkgs.writeText "powermenu.rasi" ''
    configuration {
      show-icons: false;
    }

    * {
      font: "FiraMono Nerd Font 10";
    }

    window {
      transparency:       "real";
      location:           center;
      anchor:             center;
      fullscreen:         false;
      width:              800px;
      x-offset:           0px;
      y-offset:           0px;

      enabled:            true;
      margin:             0px;
      padding:            0px;
      border:             0px solid;
      border-radius:      0px;
      border-color:       #15161e;
      cursor:             "default";
      background-color:   #15161e;
    }

    mainbox {
      enabled:            true;
      spacing:            15px;
      margin:             0px;
      padding:            30px;
      border:             0px solid;
      border-radius:      0px;
      border-color:       #15161e;
      background-color:   transparent;
      children:           [ "inputbar", "listview" ];
    }

    inputbar {
      enabled:            true;
      spacing:            15px;
      margin:             0px;
      padding:            0px;
      border:             0px;
      border-radius:      0px;
      border-color:       #15161e;
      background-color:   transparent;
      text-color:         #c0caf5;
      children:           [ "textbox-prompt-colon", "prompt"];
    }

    dummy {
      background-color: transparent;
    }

    textbox-prompt-colon {
      font:               "Font Awesome 6 Free Solid 13";

      enabled:            true;
      expand:             false;
      str:                "";
      padding:            12px 16px;
      border-radius:      0px;
      background-color:   #f7768e;
      text-color:         #15161e;
    }

    prompt {
      enabled:            true;
      padding:            12px;
      border-radius:      0px;
      background-color:   #9ece6a;
      text-color:         #15161e;
    }

    message {
      enabled:            true;
      margin:             0px;
      padding:            12px;
      border:             0px solid;
      border-radius:      0px;
      border-color:       #15161e;
      background-color:   #15161e;
      text-color:         #c0caf5;
    }
    textbox {
      background-color:     inherit;
      text-color:           inherit;
      vertical-align:       0.5;
      horizontal-align:     0.5;
      placeholder-color:    #c0caf5;
      blink:                true;
      markup:               true;
    }

    listview {
      enabled:            true;
      columns:            5;
      lines:              1;
      cycle:              true;
      dynamic:            true;
      scrollbar:          false;
      layout:             vertical;
      reverse:            false;
      fixed-height:       true;
      fixed-columns:      true;
      
      spacing:            15px;
      margin:             0px;
      padding:            0px;
      border:             0px solid;
      border-radius:      0px;
      border-color:       #15161e;
      background-color:   transparent;
      text-color:         #c0caf5;
      cursor:             "default";
    }

    element {
      enabled:            true;
      spacing:            0px;
      margin:             0px;
      padding:            40px 10px;
      border:             0px solid;
      border-radius:      0px;
      border-color:       #15161e;
      background-color:   #33467c;
      text-color:         #c0caf5;
      cursor:             pointer;
    }
    element-text {
      font:               "Font Awesome 6 Free Solid 32";
      background-color:   transparent;
      text-color:         inherit;
      cursor:             inherit;
      vertical-align:     0.5;
      horizontal-align:   0.5;
    }
    element selected.normal {
      background-color:   #7dcfff;
      text-color:         #15161e;
    }
  '';

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
in
{
  config = lib.mkIf config.gui.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        jq
      ];

      programs.rofi = {
        enable = true;
        cycle = true;
        terminal = "${pkgs.alacritty}/bin/alacritty";
        font = "FiraMono Nerd Font 12";
        extraConfig = {
          modi = "run,ssh,drun";
          show-icons = true;
          case-sensitive = false;
          display-drun = " ";
          drun-display-format = "{icon} {name}";
        };

        theme =
          let
            inherit (config.home-manager.users.${config.user}.lib.formats.rasi) mkLiteral;
          in
          {
            # TODO: change this to base16 colors
            "*" = {
              background = mkLiteral "#15161e";
              selected = mkLiteral "#33467c";
              background-search = mkLiteral "#f7768e";
              foreground = mkLiteral "#c0caf5";

              powermenu-power = mkLiteral "#f7768e";
              powermenu-uptime = mkLiteral "#9ece6a";
              powermenu-selected = mkLiteral "#7dcfff";
            };

            "window" = {
              padding = mkLiteral "0px";
              margin = mkLiteral "0px";
              border = mkLiteral "0px solid";
              border-radius = mkLiteral "0px";
              border-color = mkLiteral "@background";
              background-color = mkLiteral "@background";

              width = mkLiteral "750px";
              children = map mkLiteral [ "mainbox" ];
            };

            "mainbox" = {
              padding = mkLiteral "10px 25px";
              margin = mkLiteral "0px";
              border = mkLiteral "0px solid";
              border-radius = mkLiteral "0px";
              border-color = mkLiteral "@background";
              background-color = mkLiteral "@background";

              orientation = mkLiteral "vertical";
              spacing = mkLiteral "10px";

              children = map mkLiteral [
                "inputbar"
                "listview"
              ];
            };

            "inputbar" = {
              padding = mkLiteral "10px 10px 10px 0px";
              margin = mkLiteral "0px";
              border = mkLiteral "0px solid";
              border-radius = mkLiteral "0px";
              border-color = mkLiteral "@background";
              background-color = mkLiteral "@background";

              text-color = mkLiteral "@foreground";
              spacing = mkLiteral "10px";

              children = map mkLiteral [
                "prompt"
                "entry"
              ];
            };

            "prompt" = {
              padding = mkLiteral "7px 7px 8px 12px";
              background-color = mkLiteral "@background-search";

              text-color = mkLiteral "inherit";
              font = "Font Awesome 6 Free Solid 14";
            };

            "entry" = {
              background-color = mkLiteral "inherit";
              vertical-align = mkLiteral "0.5";

              text-color = mkLiteral "inherit";
              placeholder = "Search...";
            };

            "listview" = {
              padding = mkLiteral "0px";
              margin = mkLiteral "0px";
              border = mkLiteral "0px solid";
              border-radius = mkLiteral "0px";
              border-color = mkLiteral "@background";
              background-color = mkLiteral "@background";

              columns = 1;
              lines = 15;
              dynamic = true;
              scrollbar = false;

              spacing = mkLiteral "0px";
              layout = mkLiteral "vertical";
              fixed-width = true;
              fixed-height = true;
              text-color = mkLiteral "@foreground";
            };

            "element" = {
              padding = mkLiteral "5px";
              margin = mkLiteral "0px";
              border = mkLiteral "0px solid";
              border-radius = mkLiteral "0px";
              border-color = mkLiteral "@background";
              background-color = mkLiteral "@background";
              cursor = mkLiteral "pointer";

              spacing = mkLiteral "10px";
              text-color = mkLiteral "@foreground";

              children = map mkLiteral [
                "element-icon"
                "element-text"
              ];
            };

            "element normal.normal" = {
              background-color = mkLiteral "@background";
              text-color = mkLiteral "@foreground";
            };

            "element normal.urgent" = {
              background-color = mkLiteral "@background";
              text-color = mkLiteral "@foreground";
            };

            "element normal.active" = {
              background-color = mkLiteral "@background";
              text-color = mkLiteral "@foreground";
            };

            "element selected.normal" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@foreground";
            };

            "element selected.urgent" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@foreground";
            };

            "element selected.active" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@foreground";
            };

            "element alternate.normal" = {
              background-color = mkLiteral "@background";
              text-color = mkLiteral "@foreground";
            };

            "element alternate.urgent" = {
              background-color = mkLiteral "@background";
              text-color = mkLiteral "@foreground";
            };

            "element alternate.active" = {
              background-color = mkLiteral "@background";
              text-color = mkLiteral "@foreground";
            };

            "element-icon" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
              cursor = mkLiteral "inherit";
              size = mkLiteral "25px";
            };

            "element-text" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
              highlight = mkLiteral "inherit";
              cursor = mkLiteral "inherit";
              vertical-align = mkLiteral "0.5";
            };
          };
      };

      xdg.configFile."rofi/powermenu.rasi".source = powermenuRasi;
    };

    gui.launcherCmd = "${rofi}/bin/rofi -show drun";
    gui.powermenuCmd = "${powermenuScript}/bin/rofi-powermenu";
  };
}
