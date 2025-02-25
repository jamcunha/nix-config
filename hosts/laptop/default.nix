{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  programs.dconf.enable = true;

  # Monitor Backlight
  programs.light.enable = true;

  # NVIDIA Config
  hardware.nvidia = {
    open = false;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  # MSI Configuration
  environment.systemPackages = [ pkgs.mcontrolcenter ];

  # On the go spec
  specialisation = {
    no-dgpu.configuration = {
      imports = [ inputs.hardware.nixosModules.common-gpu-nvidia-disable ];

      powerManagement.cpuFreqGovernor = lib.mkForce "powersave";

      # TODO: try some tlp or other power saving methods
    };
  };

  # Module config
  docker.enable = true;
  nix-ld.enable = true;
  kanata.enable = true;

  system.stateVersion = "24.05";
}
