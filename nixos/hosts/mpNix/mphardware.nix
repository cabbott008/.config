# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Variables
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5"; # Effects Obsidian & Vivaldi
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    XCURSOR_SIZE = "96"; # Also added Xft.dpi: 192 to .Xresources in ~
  };
    
  services.xserver = {
    dpi = 288;
    upscaleDefaultCursor = true;
  };

  services.mbpfan.enable = true;
  services.fstrim.enable = true;
}
