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
      # tested stable and production drivers. legacy_535 is incompatible with dxvk
      # hoping beta drivers will fix the issue
      package = config.boot.kernelPackages.nvidiaPackages.beta;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };
  };
}
