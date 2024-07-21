{ inputs, globals, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    inputs.home-manager.nixosModules.home-manager {
      home-manager.users."afonso" = import ../../home/afonso;
    }

    ./nix.nix

    # Keep while migrating
    ./default-bak.nix

    # ^-------^ remove after migration ^-------^

    globals

    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.hardware.nixosModules.common-cpu-intel-comet-lake
    inputs.hardware.nixosModules.common-gpu-nvidia-disable
    inputs.hardware.nixosModules.common-pc-ssd

    ../../modules/common
    ../../modules/nixos

    {
      networking.networkmanager.enable = true;
      networking.hostName = "laptop";

      boot = {
        initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
          kernelModules = [ ];
        };

        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      hardware.enableRedistributableFirmware = true;
      hardware.cpu.intel.updateMicrocode = true;

      # temp fix for temperature (?? have profiles for cpuFreqGovernor)
      powerManagement.cpuFreqGovernor = "powersave";

      userGroups = [
        "networkmanager"
        "video"
      ];

      # NixOS related config
      gui = {
        enable = true;
        wm.bspwm = true;
      };

      soundCfg.enable = true;

      # Programs and services
      alacritty.enable = true;
    }
  ];
}
