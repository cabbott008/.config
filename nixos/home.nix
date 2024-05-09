{ config, pkgs, lib, home-manager, ... }:

{
  home = {
    stateVersion = "24.05";
    username = "ca";
    homeDirectory = lib.mkForce "/home/ca";
    
    sessionVariables = {
    };

    packages = [
    ];
    
    file = {
    };
  };

  programs = {
    home-manager = {
      enable = true;
#     backupFileExtension = "backup";
    };  
    fish.enable = true;
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
}
