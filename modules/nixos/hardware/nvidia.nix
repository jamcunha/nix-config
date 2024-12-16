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

      # FIX: if it continues to free, try the production driver -> legacy_535

      # test
      package = config.boot.kernelPackages.nvidiaPackages.production;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };
  };
}
