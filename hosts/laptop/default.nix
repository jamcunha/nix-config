{ inputs, globals, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager

    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.hardware.nixosModules.common-cpu-intel-comet-lake
    inputs.hardware.nixosModules.common-pc-ssd

    # GPU Settings
    {
      imports = [ inputs.hardware.nixosModules.common-gpu-nvidia ];

      hardware.nvidia.prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
      };

      specialisation = {
        no-dgpu.configuration = {
          imports = [ inputs.hardware.nixosModules.common-gpu-nvidia-disable ];
        };
      };
    }


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

      # ---- Sort this -----------------------

      environment.systemPackages = let
        pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      in with pkgs; [
        # TODO: add to a keybind
        brightnessctl

        mcontrolcenter # MSI Control Center
      ];

      # not for steam but for useful options
      programs.steam.enable = true;
      programs.gamemode.enable = true;

      # --------------------------------------

      # NixOS related config
      gui = {
        enable = true;
        wm.bspwm = true;
      };

      soundCfg.enable = true;
      nix-ld.enable = true;

      virt-manager.enable = true;
      docker.enable = true;

      # Programs and services
      alacritty.enable = true;
      direnv.enable = true;
      mpv.enable = true;
      neovim.enable = true;
      tmux.enable = true;

      # temp
      starship.enable = true;
    }
  ];
}
