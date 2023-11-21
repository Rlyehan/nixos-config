{ username, hyprland, ... }: {
  imports = [
    ./programs
    ./hyprland
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "max";
    homeDirectory = "/home/max";

    stateVersion = "23.05";
  };

    # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
