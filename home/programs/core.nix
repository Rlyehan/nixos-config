{pkgs, ...}: {
  home.packages = with pkgs; [
    zip
    xz
    unzip

    gnugrep
    gnused
    gawk
    ripgrep
    which
    file
    glow
    ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      };

    fzf = {
      enable = true;
      };
    };
}
