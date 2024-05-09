{
  description = "Curtis's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#   home-manager = {
#     url = "github:nix-community/home-manager";
#     inputs.nixpkgs.follows = "nixpkgs";
#   };
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
#   nixvim = {
#     url = "github:nix-community/nixvim";
#     inputs.nixpkgs.follows = "nixpkgs";
#   };
    
#   nix-colors = {
#     url = "github:misterio77/nix-colors";
#     inputs.nixpkgs.follows = "nixpkgs";
#   };
  };

  outputs = { self, nixpkgs, ...} @ inputs: {
    nixosConfigurations = {

      mpNix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/mpNix/mpNix.nix
#         home-manager.nixosModules.home-manager
#         {
#           home-manager.useGlobalPkgs = true;
#           home-manager.useUserPackages = false;
#           home-manager.users.ca = import ./home.nix;
#         }
        ];
      };

      iNix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [./hosts/iNix/iNix.nix];
      };

      tNix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [./hosts/tNix/tNix.nix];
      };

      xiso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [./hosts/xiso/xiso.nix];
      };
    };
  };
}
