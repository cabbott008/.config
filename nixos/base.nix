# ----- * NixOS Default Config* - base.nix ----- 

{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
#   inputs.nixvim.nixosModules.nixvim
#   ./modules/nixvim.nix
  ];

  # Variables
  environment.sessionVariables = {
    FLAKE = "/home/ca/.config/nixos";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
  services = {
    xserver = {
      enable = true;
      autorun = false;
      desktopManager = {
        wallpaper.mode = "fill";
      };
      windowManager.qtile = {
        enable = true;
      };
      xkb = {
        layout = "us";
        variant = "";
        options = "caps:escape";
      };
      displayManager = {
        sessionCommands = ''
          ${pkgs.sxhkd}/bin/sxhkd &
        '';
      };
      excludePackages = with pkgs; [ xterm ];
      };
    libinput = {
      touchpad.naturalScrolling = true;
      mouse.naturalScrolling = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        autoLogin.relogin = true;
        settings = {
          Autologin = {
            Session = "none+qtile";
            User = "ca";
	  };
	};
      };
    };
  };

  # Misc. Services 
  services = {
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    clipmenu.enable = true;
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

  # Define a user account. 
  users.users.ca = {
    isNormalUser = true;
    extraGroups = [
      "sudo"
      "networkmanager"
      "wheel"
    ];
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

  # Power Management
  powerManagement = {
    enable = true;
    #     powertop.enable = true;
  };
  services = {
    logind = {
      powerKey = "hybrid-sleep";
      powerKeyLongPress = "poweroff";
    };
    auto-cpufreq.enable = true;
    tlp.enable = true;
    upower = {
      enable = true;
      ignoreLid = true;
    };
  };

  # Fonts
  fonts.packages = with pkgs; [ ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    neovim
    xclip
    fish
    wget
    tree
    feh
    git
    sxhkd
    vifm
    rofi
    rofimoji
    trash-cli
    vivaldi
    obsidian
    audacity
    kitty
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
    gimp
    fastfetch
    remmina
    unzip
  ];

  # DO NOT ALTER OR DELETE
  system.stateVersion = "24.05";
} 
