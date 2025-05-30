{ pkgs, ... }:

{
  # Hyprland configuration through home-manager
  # Note: `programs.hyprland.enable = true;` is set in system/desktop.nix
  # This file is for user-specific hyprland settings.

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

      # Assign workspaces to monitors
      workspace = [ "1, monitor:DP-1" ];

      # Execute your favorite apps at launch
      exec-once = [
        "waybar" # If you use waybar
        # "swaybg -i ~/Pictures/wallpapers/your-wallpaper.png" # Example for setting a wallpaper
        # Add other startup applications
      ];

      # Source a file (multi-file configs)
      # source = "~/.config/hypr/myColors.conf"

      # Some default env vars.
      env = [ "XCURSOR_SIZE,24" ];

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "us, ru";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;

        # sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/#general
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle"; # master or dwindle

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/#decoration
        rounding = 5;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        # drop_shadow = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile =
          true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/#gestures
        workspace_swipe = false;
      };

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/#misc
        force_default_wallpaper =
          -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true;
      };

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
      "$menu" =
        "pkill rofi || rofi -show drun -modes drun,window,ssh -show-icons";

      bind = [
        # "$mainMod, Q, exec, kitty" # Launch terminal (kitty in this case)
        "$mainMod SHIFT, Q, killactive," # New keybinding to kill active window
        # "$mainMod, M, exit,"
        # "$mainMod, E, exec, nemo" # Example: Launch file manager (nemo)
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu" # Launch application launcher (rofi)
        # "$mainMod, P, pseudo," # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Screenshots
        "$mainMod, Print, exec, env HYPRSHOT_DIR=$HOME/Pictures hyprshot -m window"
        ",Print, exec, env HYPRSHOT_DIR=$HOME/Pictures hyprshot -m output"
        "$mainMod SHIFT, Print, exec, env HYPRSHOT_DIR=$HOME/Pictures hyprshot -m region"

        # Example special keys
        # ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        # ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        # ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        # ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        # ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"

        # Scroll through existing workspaces with mainMod + scroll
        # "$mainMod, mouse_down, workspace, e+1"
        # "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Example window rules
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # windowrulev2 = size 800 600,class:^(kitty)$,title:^(kitty)$
      # windowrulev2 = move 75 44,class:^(kitty)$,title:^(kitty)$
      windowrulev2 = [
        "float, class:^(Pavucontrol)$"
        "size 800 600, class:^(Pavucontrol)$"
        "center, class:^(Pavucontrol)$"
        "float, class:^(Volume Control)$"
        "size 800 600, class:^(Volume Control)$"
        "center, class:^(Volume Control)$"
      ];
    };

    # You can also set Hyprland environment variables here if needed
    # extraConfig = ''
    #   env = WLR_NO_HARDWARE_CURSORS,1
    # '';
  };
}
