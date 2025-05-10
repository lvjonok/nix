{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true; # This enables home-manager's hyprland module
    # package = pkgs.hyprland; # Optionally specify a hyprland package
    # plugins = [ pkgs.hyprsome ]; # Example plugin

    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        "HDMI-A-1,2560x1440@60,0x0,1,transform,1"
        "DP-1,2560x1440@165,1440x0,1"
      ];

      # Execute your favorite apps at launch
      exec-once = [
        "waybar" # If you use waybar
        # "swaybg -i ~/Pictures/wallpapers/your-wallpaper.png" # Example for setting a wallpaper
        # Add other startup applications
      ];
    };
  };

}
