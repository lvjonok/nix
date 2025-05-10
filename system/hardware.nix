{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  services.xserver.videoDrivers = [ "nvidia" ]; # Ensure this matches your hardware

  hardware.nvidia = {
    modesetting.enable = true; # Required for Wayland
    powerManagement.enable = true; # Required for hibernate
    powerManagement.finegrained = false;
    forceFullCompositionPipeline = false; # NOTE: may cause issues with WebGL
    open = true; # Use open-source kernel modules if available and preferred
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta; # Or .stable, .production
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
