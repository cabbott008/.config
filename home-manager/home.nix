{ config, pkgs, ... }:

{
  home.username = "ca";
  home.homeDirectory = "/home/ca";

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      bashrcExtra = ''
        if [[ $- == *i* && $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" ]]
        then
          exec ${pkgs.fish}/bin/fish
        fi
      '';
    };
    git = {
      enable = true;
      userName = "cabbott008";
      userEmail = "curtisabbott@me.com";
    };
  };

  home.stateVersion = "23.11"; # DO NOT ALTER or DELETE
}
