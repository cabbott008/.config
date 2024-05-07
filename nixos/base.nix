# ----- * NixOS Default Config* - base.nix ----- 

{ config, pkgs, lib, ... }:
{
  # Variables
    environment.sessionVariables = {
      FLAKE = "/home/ca/.config/nixos";
    };

  # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Network Settings
    hardware.bluetooth.enable = true;
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
      useDHCP = lib.mkDefault true;
      wireless = {
        iwd = {
          enable = true;
          settings = {
            IPv6.Enabled = true;
            Settings = {
              AutoConnect = true; 
            };
          };
        };
      };
    };

  # Enable X11 and Desktop Environment
    services.xserver = {
      enable = true;
      autorun = false;
      libinput = {
        touchpad.naturalScrolling = true;
        mouse.naturalScrolling = true;
      };
      displayManager = {
        lightdm.enable = true;
#        startx.enable = true;
#       defaultSession = "none+qtile"; 
        sessionCommands = ''
          ${pkgs.sxhkd}/bin/sxhkd &
        '';
      };  
      desktopManager = {
        wallpaper.mode = "fill";
      };
      windowManager.qtile = {
        enable = true;
      };
      xkb = {
        layout = "us";
        variant = "";
        options ="caps:escape";
      };
      excludePackages = with pkgs; [
        xterm
      ];
    };

  # Misc. Services 
    services = {
      gnome3.gnome-keyring.enable = true;
      openssh.enable = true;
      printing.enable = true;
      udisks2.enable = true;
    };
  
  # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  # Allow unfree packages
    nixpkgs.config = {
      allowUnfree = true;
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      networkmanagerapplet
      wget
      tree
      git
      gh
      sxhkd
      feh
      neovim
      fish
      vifm
      rofi
      rofimoji
      trash-cli
      vivaldi
      obsidian
      audacity 
      kitty
      pass
      fzf
      fd
      btop
      eza
      ripgrep
      ffmpeg
      flameshot
      nh
      nix-output-monitor
      nvd
      pavucontrol
      libqalculate
      bluez
      bluez-tools
      bluetuith
      zathura
      vlc
      yt-dlp
      audacity
      dunst
      mpv
      flatpak
      obs-studio
      pcmanfm
      rsync
      gimp
      fastfetch
      remmina
      unzip
    ];

  # Fonts
    fonts.packages = with pkgs; [
    ];
  
  # Define a user account. 
    users.users.ca = {
      isNormalUser = true;
      extraGroups = [ "sudo" "networkmanager" "wheel" ]; 
    };

  # Set your time zone.
    time.timeZone = "America/Chicago";

  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_INDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

  # DO NOT ALTER OR DELETE
    system.stateVersion = "24.05";
}
