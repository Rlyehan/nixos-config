{
  config,
  lib,
  pkgs,
  userfullname,
  useremail,
  ...
  }: {
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
    '';

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = userfullname;
    userEmail = useremail;

    aliases = {
     st = "status";
     };
  };
}
