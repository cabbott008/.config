####### Special Config mpNix.nix #######

{ config, inputs, lib, modulesPath, home-manager, ... }:

{
  imports = [
      ./mphardware.nix
      inputs.disko.nixosModules.default
        (import ./mpdisko.nix { device = "/dev/sda"; })  
      ../../base.nix
    ];

    networking.hostName = "mpNix";

    home-manager = {
      extraSpecialArgs = { inherit inputs;};
      users = {
        "ca" = import ../../home.nix;
      };
    };
}
