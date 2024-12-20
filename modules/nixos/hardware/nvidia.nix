{
  config,
  pkgs,
  ...
}:

# TODO: add options (may need to refactor config structure)
# NOTE: don't know why but it's infinite recursion to add the inputs import

{
  config = {
    hardware.nvidia = {
      open = false;

      # FIX: random game and mpv freezes with nvidia
      #      tested stable, production and beta drivers (all the same)
      #      think it's beacause of dxvk, testing without using it (if it works change to stable)
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };
  };
}
