{
  config,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  programs.firefox = {
    enable = true;
    package =
      if cfg.displayServerProtocol == "wayland"
      then pkgs.firefox-wayland
      else pkgs.firefox;
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

  home.sessionVariables.BROWSER = "firefox";
}
