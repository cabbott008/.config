# home.nix

{ lib, pkgs, inputs, osConfig, ... }:

{ 
  imports = [
#   inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.packages = [
  ];

  programs = {
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

  xsession.enable = true;

  home.stateVersion = "23.11"; # DO NOT ALTER or DELETE

}

################# Bin ###################

# home.persistence."/persist/home/ca" = {
#   directories = [
#     ".cache"
#     ".config"
#     ".local"
#     "Documents"
#     "Downloads"
#     "Music"
#     "Pictures"
#     "Sources"
#     "VMs"
#     "Videos"
#     "nixos"
#   ];
#   files = [
#     ".bash_history"
#     ".nix_profile"
#   ];
#   allowOther = true;
# };
