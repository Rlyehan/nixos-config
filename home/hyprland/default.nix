{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
    config = mkIf cfg.enable {
        home.file.".config/hypr" = {
    source = ./hypr-conf;
    recursive = true;
    };
    };
}