{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mySettings;
in {
  imports = [
    ./settings.nix

    ../../nixos/app/docker.nix
    ../../nixos/app/gamemode.nix
    ../../nixos/app/kanata.nix
    ../../nixos/app/lutris.nix
    ../../nixos/app/prismlauncher.nix
    ../../nixos/app/steam.nix
    ../../nixos/app/virtualization.nix

    ../../nixos/desktop/bspwm.nix

    ../../nixos/hardware/kernel.nix
    ../../nixos/hardware/printing.nix

    ../../nixos/system/locale.nix
    ../../nixos/system/user.nix
    ../../nixos/system/nix.nix

    ./hardware-configuration.nix

    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-gpu-nvidia

    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.hostName = cfg.hostname;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      open = false;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  specialisation = {
    no-dgpu.configuration = {
      imports = [inputs.hardware.nixosModules.common-gpu-nvidia-disable];

      # temp fix for temperature (?? have profiles for cpuFreqGovernor)
      powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
    };
  };

  # MSI Control Center
  environment.systemPackages = [pkgs.mcontrolcenter];

  # Monitor Backlight
  programs.light.enable = true;

  system.stateVersion = "24.05";
}
