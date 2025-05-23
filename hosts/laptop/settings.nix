{
  lib,
  pkgs,
  ...
}: {
  imports = [../../modules/settings.nix];

  mySettings = {
    hostname = "laptop";
    username = "afonso";
    name = "Joaquim Cunha";
    email = "joaquimafonsocunha@gmail.com";

    timezone = "Europe/Lisbon";
    locale = "pt_PT.UTF-8";

    kanata.devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];

    printing.drivers = [
      # Epson Driver
      pkgs.epson-escpr
    ];

    displayServerProtocol = "x11";
  };
}
