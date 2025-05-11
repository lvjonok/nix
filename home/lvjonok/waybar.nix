{ pkgs, ... }:
let
  common = {
    height = 30;
    # width = 1280; # Uncomment if you want a fixed width
    spacing = 4;
  };
in
{
  programs.waybar = {
    enable = true;
    # package = pkgs.waybar; # Or a specific variant like pkgs.waybar-hyprland
    settings = {
      mainBar = {
        # You can define multiple bars, "mainBar" is just a name
        layer = "top";
        position = "top"; # "top", "bottom", "left", "right"
        output = [ "DP-1" ];
        # Modules left
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        # Modules center
        modules-center = [ "hyprland/window" ];
        # Modules right
        modules-right = [
          "custom/nvidia"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "clock"
          "tray"
          "custom/notifications"
          "hyprland/language"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            # "1" = "";
            # "2" = "";
            # "3" = "";
            # "4" = "";
            # "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
          # persistent_workspaces = {
          #   "*" = [1 2 3 4 5]; # Show workspaces 1-5 always, adjust to your monitor setup
          # };
        };
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };
        "clock" = {
          format = "{:%Y-%m-%d %H:%M:%S}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          interval = 1;
        };
        "cpu" = {
          format = "CPU: {usage}% ";
          tooltip = true;
        };
        "memory" = { format = "MEM: {}% "; };
        # height = 30; # Removed, as it's in common
        # width = 1280; # Uncomment if you want a fixed width
        # spacing = 4; # Removed, as it's in common
        "temperature" = {
          exec = "sensors | awk '/Package id 0:/ {print $4+0}'"; # Updated exec command
          format = "{}°C "; # Added °C for clarity, ensure exec outputs only number
          interval = 5; # Update every 5 seconds
          critical-threshold = 80;
          format-critical = "{}°C "; # Added °C
          tooltip = true; # Added for debugging
        };
        "custom/nvidia" = {
          exec =
            "get-nvidia-stats"; # Name of the script defined in packages.nix
          format = "{}"; # The script outputs JSON with a "text" field
          return-type = "json";
          interval = 2; # Update every 2 seconds
          tooltip = true; # The script provides a "tooltip" field
          # You can add class for styling, e.g. "class": "nvidia-stats",
        };
        "custom/notifications" = {
          format = "{output}";
          exec = "makoctl list";
          interval = 5;
          tooltip = false;
        };
        "network" = {
          # interface = "wlp2s0"; # Select interface
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          # scroll-step = 1; # %, can be a float
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        # "battery" = {
        #   states = {
        #     good = 95;
        #     warning = 30;
        #     critical = 15;
        #   };
        #   format = "{capacity}% {icon}";
        #   format-charging = "{capacity}% ";
        #   format-plugged = "{capacity}% ";
        #   format-alt = "{time} {icon}";
        #   format-icons = ["" "" "" "" ""];
        # };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      } // common;
      secondBar = {
        layer = "top";
        position = "top";
        # height = 30; # Already in common
        # spacing = 4; # Already in common
        output = [ "HDMI-A-1" ];
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "clock" "tray" ];
        "clock" = {
          # // "timezone": "America/New_York",
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          interval = 1;
          format = "{:%H:%M:%S}";
          format-alt = "{:%Y-%m-%d}";
        };
        "tray" = { spacing = 10; };
        "hyprland/workspaces" = {
          format = "<sub>{icon}</sub>";
          format-window-separator = " ";
        };
      } // common; # // Apply common settings to secondBar
    };
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          /* Update font-family to include Nerd Fonts. Order matters. */
          font-family: Cantarell, "JetBrainsMono Nerd Font", "Symbols Nerd Font", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          border: none;
          border-radius: 0;
          min-height: 0; /* Important for vertical bars */
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          border-bottom: 3px solid #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #tray,
      #mode,
      #custom-media,
      #custom-nvidia { /* Added #custom-nvidia for potential styling */
          padding: 0 10px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
    '';
  };
}
