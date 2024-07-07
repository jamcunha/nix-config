{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.hardware.nixosModules.common-cpu-intel-comet-lake
    inputs.hardware.nixosModules.common-gpu-nvidia-disable
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    ./users/afonso.nix

    # TODO: organize this files to be common to all systems
    ./pipewire.nix
    ./nix.nix
  ];

  # temp fix for temperature
  powerManagement.cpuFreqGovernor = "powersave";

  networking.hostName = "laptop"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Lisbon";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape";
    };

    windowManager.bspwm.enable = true;
    desktopManager.xterm.enable = false;

    displayManager.lightdm.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  environment.systemPackages = with pkgs; [
    stow # try to replace with xdg.configFile in home-manager

    alsa-utils
    brightnessctl
    bspwm

    gcc
    gdb

    go
    gopls

    lightdm

    lua

    gnumake

    mcontrolcenter # MSI Control Center

    picom
    playerctl
    (polybar.override { pulseSupport = true; })
    pulseaudio
    # valgrind
    # (vscode)

    # just to have `uptime --pretty`
    procps

    # gtk theme
    dconf
  ];

  programs.dconf.enable = true;

  # Brave 126.1.67.123 buggy without compositor
  # Picom installed temporarily
  services.picom.shadow = false;

  hardware.graphics.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
