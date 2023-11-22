{ pkgs, anyrun, ... }:

{
  imports = [
    anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        randr
        rink
        shell
        symbols
        translate
      ];

      width.fraction = 0.3;
      y.absolute = 15;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    # custom css for anyrun, based on catppuccin-mocha
    extraCss = ''
    @define-color bg-col rgba(25, 27, 39, 0.7); /* Dark background color */
    @define-color bg-col-light rgba(76, 86, 106, 0.7); /* Lighter shade for background highlights */
    @define-color border-col rgba(25, 27, 39, 0.7); /* Border color similar to the background */
    @define-color selected-col rgba(100, 116, 139, 0.7); /* Selected item color */
    @define-color fg-col #a9b1d6; /* Primary text color */
    @define-color fg-col2 #7aa2f7; /* Secondary text color, a lighter shade */

    * {
    transition: 200ms ease;
    font-family: "JetBrainsMono Nerd Font";
    font-size: 1.3rem;
    }

    #window {
    background: transparent;
    }

    #plugin,
    #main {
    border: 3px solid @border-col;
    color: @fg-col;
    background-color: @bg-col;
    }
    /* anyrun's input window - Text */
    #entry {
    color: @fg-col;
    background-color: @bg-col;
    }

    /* anyrun's ouput matches entries - Base */
    #match {
    color: @fg-col;
    background: @bg-col;
    }

    /* anyrun's selected entry - Red */
    #match:selected {
    color: @fg-col2;
    background: @selected-col;
    }

    #match {
    padding: 3px;
    border-radius: 16px;
    }

    #entry, #plugin:hover {
    border-radius: 16px;
    }

    box#main {
    background: rgba(25, 27, 39, 0.7);
    border: 1px solid @border-col;
    border-radius: 15px;
    padding: 5px;
    }
    '';
  };

}
