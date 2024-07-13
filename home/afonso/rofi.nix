{ config, pkgs, ... }: {
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

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
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

        children = map mkLiteral [ "inputbar", "listview" ];
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

        children = map mkLiteral [ "prompt", "entry" ];
      };

      "prompt" = {
        padding = mkLiteral "7px 7px 8px 12px";
        background-color = mkLiteral "@background-search";

        text-color = mkLiteral "inherit";
        font = mkLiteral "Font Awesome 6 Free Solid 14";
      };

      "entry" = {
        background-color = mkLiteral "inherit";
        vertical-align = 0.5;

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

        children = map mkLiteral [ "element-icon", "element-text" ];
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
        vertical-align = 0.5;
      };
    }
  };
}
