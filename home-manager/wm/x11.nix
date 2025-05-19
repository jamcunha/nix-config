{pkgs, ...}: {
  home.packages = with pkgs; [
    xorg.xkill
    xorg.xrandr
    xorg.xinput
    xorg.setxkbmap
    xclip
  ];
}
