{lib, ...}: {
  options.mySettings = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Specifies the user's account name.";
    };

    name = lib.mkOption {
      type = lib.types.str;
      description = "Specifies the user's name.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Specifies the user's email.";
    };

    timezone = lib.mkOption {
      type = lib.types.str;
      description = "Specifies the timezone.";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      description = "Specifies the locale.";
    };

    kanata.devices = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Path to keyboard devices";
    };

    kernel.kernelPackages = lib.mkOption {
      type = lib.types.package;
      description = "Specifies which kernel to use. Default is `pkgs.linuxPackages_latest`.";
    };
    printing.drivers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "Printer drivers to use";
      default = [];
    };
  };
}
