####### Special Config tNix.nix #######

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      ./thardware.nix
      inputs.disko.nixosModules.default
        (import ./tdisko.nix { device = "/dev/sda"; })  
      ../../base.nix
    ];

    networking.hostName = "tNix";

  # Services
    services.xserver = {
      displayManager = {
        lightdm.background = /home/ct/.config/lightdm;
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
