{
  description = "NixOS flae";

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixos-generators,
    ...
  }: let
    username = "max";
    userfullname = "Maximilian Huber";
    useremail = "maximilian.hub@proton.me";

    x64_system = "x86_64-linux";
    allSystems = [x64_system];

    nixosSystem = import ./lib/nixosSystem.nix;


    modules_hyprland = {
      nixos-modules = [
        ./hosts
        ./modules/hyprland.nix
      ];
      home-module = import ./home/default.nix;
    };

    x64_specialArgs =
      {
        inherit username userfullname useremail;
        # use unstable branch for some packages to get the latest updates
        pkgs-unstable = import nixpkgs-unstable {
          system = x64_system; # refer the `system` parameter form outer scope recursively
          # To use chrome, we need to allow the installation of non-free software
          config.allowUnfree = true;
        };
      }
      // inputs;
  in {
    nixosConfigurations = let
      base_args = {
        inherit home-manager nixos-generators;
        nixpkgs = nixpkgs; # or nixpkgs-unstable
        system = x64_system;
        specialArgs = x64_specialArgs;
      };
    in {
      # with hyprland compositor
      hyprland = nixosSystem (modules_hyprland // base_args);
    };

    # take system images
    # https://github.com/nix-community/nixos-generators
    packages."${x64_system}" =
      # genAttrs returns an attribute set wth the given keys and values(host => image).
      nixpkgs.lib.genAttrs [
        "hyprland"
      ] (
        # generate iso image for hosts with desktop environment
        host:
          self.nixosConfigurations.${host}.config.formats.iso
      );

    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter = nixpkgs.lib.genAttrs allSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );
    };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # There are many ways to reference flake inputs. The most widely used is github:owner/name/reference,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos's stable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # modern window compositor
    hyprland.url = "github:hyprwm/Hyprland";
    # community wayland nixpkgs
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # anyrun - a wayland launcher
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # generate iso/qcow2/docker/... image from nixos configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    ########################  Color Schemes  #########################################

    # color scheme - catppuccin
    catppuccin-btop = {
      url = "github:catppuccin/btop";
      flake = false;
    };
    catppuccin-fcitx5 = {
      url = "github:catppuccin/fcitx5";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-alacritty = {
      url = "github:catppuccin/alacritty";
      flake = false;
    };
    catppuccin-wezterm = {
      url = "github:catppuccin/wezterm";
      flake = false;
    };
    catppuccin-helix = {
      url = "github:catppuccin/helix";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    cattppuccin-k9s = {
      url = "github:catppuccin/k9s";
      flake = false;
    };
  };

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [


      "https://cache.nixos.org"
      "https://anyrun.cachix.org"
      "https://hyprland.cachix.org"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
