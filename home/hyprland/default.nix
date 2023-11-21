{pkgs, hyprland, catppuccin-hyprland, ...}: {

  # hyprland configs, based on https://github.com/notwidow/hyprland
  home.file.".config/hypr" = {
    source = ./hypr-conf;
    # copy the scripts directory recursively
    recursive = true;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
  };

}