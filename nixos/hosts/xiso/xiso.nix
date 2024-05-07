# ----- * NixOS * - xiso.nix ----- 

{ config, lib, pkgs, inputs, modulesPath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
      "${modulesPath}/installer/cd-dvd/channel.nix"
      ./xisohardware.nix
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Lastest Version
    boot.kernelPackages = pkgs.linuxPackages_latest;

  # Extra Features  
    nix = {
      settings.experimental-features = [ "nix-command" "flakes" ];
      extraOptions = "experimental-features = nix-command flakes";
    };

  # Network Settings
    networking = {
      hostName = "iso";
      wireless.iwd = {
        enable = true;
      };  
      networkmanager = {
        enable = true;
          wifi.backend = "iwd";
     };
    };

  # Set your time zone.
    time.timeZone = "America/Chicago";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
    nixpkgs.config = {
      allowUnfree = true;
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      git
      neovim
      vifm
    ];

  # gnome power settings do not turn off screen
    systemd = {
      services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
      targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
      };
    };
  
  # Extra Flexibility
    home-manager.users.nixos = import ./home.nix;
    users.extraUsers.root.password = "nixos";
    services.openssh.settings.PermitRootLogin = lib.mkForce "yes"; 
}
