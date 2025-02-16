{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./mouse.nix
    ./sound.nix
  ];

  # TODO: add nvidia driver options

  # Maybe add some options to difference a server
}
