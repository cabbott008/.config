####### Special Config iNix.nix #######

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./ihardware.nix
      inputs.disko.nixosModules.default
        (import ./idisko.nix { device = "/dev/sda"; })  
      ../../base.nix
    ];

    networking.hostName = "iNix";

  # Services
    services.xserver = {
      displayManager = {
        lightdm.background = /home/wa/.config/lightdm;
      };
    };

  # Define additional user accounts. 
    users.users.ct = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" ]; 
    };

    users.users.wa = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" ]; 
    };
}
