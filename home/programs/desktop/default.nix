{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./media.nix
    ./xdg.nix
  ];
}
