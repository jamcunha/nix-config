{ lib, ... }: {
  options = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Your username";
    };

    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Host name";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Full name";
    };

    gitName = lib.mkOption {
      type = lib.types.str;
      description = "Git name";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      description = "Your git email";
    };
  };
}
