{pkgs, hyprland, ...}: {

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        defaultSession = "hyprland";
        lightdm.enable = false;
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  programs = {
    hyprland = {
      enable = true;
    
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };

    # monitor backlight control
    light.enable = true;

    # thunar file manager(part of xfce) related options
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    waybar # the status bar
    swaybg # the wallpaper
    swayidle # the idle timeout
    swaylock # locking the screen
    wlogout # logout menu
    wl-clipboard # copying and pasting
    grim # taking screenshots

    mako # the notification daemon, the same as dunst

    yad # a fork of zenity, for creating dialogs

    networkmanagerapplet # provide GUI app: nm-connection-editor

    xfce.thunar # xfce4's file manager
  ];

  # fix https://github.com/ryan4yin/nix-config/issues/10
  security.pam.services.swaylock = {};
}
