{pkgs, ...}: {
  home.packages = with pkgs; [
    gnumake
    criterion # unit tests
  ];
}
