{
  inputs,
  globals,
  lib,
  ...
}:
lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {inherit inputs;};

  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager

    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-gpu-nvidia

    ../../modules/common
    ../../modules/nixos

    {
      networking.networkmanager.enable = true;
      networking.hostName = "laptop";

      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
          kernelModules = [];
        };

        kernelModules = ["kvm-intel"];
        extraModulePackages = [];
      };

      hardware.enableRedistributableFirmware = true;

      hardware.nvidia = {
        open = false;

        prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:2:0:0";
        };
      };

      powerManagement = {
        enable = true;
        cpuFreqGovernor = "ondemand";
      };

      userGroups = [
        "networkmanager"
        "video"
      ];

      environment.systemPackages = let
        pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
      in [
        pkgs.mcontrolcenter # MSI Control Center
      ];

      # monitor backlight
      programs.light.enable = true;

      # ---- Sort this -----------------------

      # not for steam but for useful options
      programs.steam.enable = true;
      programs.gamemode.enable = true;

      # --------------------------------------

      specialisation = {
        no-dgpu.configuration = {
          imports = [inputs.hardware.nixosModules.common-gpu-nvidia-disable];

          # temp fix for temperature (?? have profiles for cpuFreqGovernor)
          powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
        };
      };

      # NixOS related config
      gui = {
        enable = true;
        wm.bspwm = true;
      };

      sound-cfg.enable = true;
      nix-ld.enable = true;

      docker.enable = true;

      # Programs and services
      alacritty.enable = true;
      direnv.enable = true;
      mpv.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      spotify.enable = true;
      kanata.enable = true;

      programming-languages.enable = true;

      # temp
      # starship.enable = true;
    }
  ];
}
