####### Special Config mpNix.nix #######

{ config, inputs, lib, modulesPath, ... }:

{
  imports = [
      ./mphardware.nix
      inputs.disko.nixosModules.default
        (import ./mpdisko.nix { device = "/dev/sda"; })  
      ../../base.nix
    ];

    networking.hostName = "mpNix";
}
