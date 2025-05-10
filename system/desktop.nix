{ ... }:

{
  # Enable the X11 windowing system.
  # You can disable this if you're only using a Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment (example, if you were using it).
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true; # Or plasma5

  # Hyprland (as per your original config)
  programs.hyprland.enable = true;
  # Assuming sddm is still desired for Hyprland, otherwise choose a different DM or none
  services.displayManager.sddm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
