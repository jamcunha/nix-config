{pkgs, ...}: {
  fonts.packages = with pkgs; [
    font-awesome

    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontDir.enable = true;
}
