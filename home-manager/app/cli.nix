{pkgs, ...}: {
  # Some commonly used CLI apps

  home.packages = with pkgs; [
    htop # Process viewer
    qalc # Calculator
    ncdu # Disk Usage
    eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl (good for testing API's)
    jq # JSON pretty printer

    zip # Compress files and folders
    unzip # Extract compressed files and folders
    fzf # Fuzzy finder
    tldr # Common use cases of terminal programs
    tree # Indented ls

    binutils
    gnugrep
    wget
    curl
  ];
}
