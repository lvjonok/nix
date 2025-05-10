{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # From original user packages
    # kdePackages.kate

    # From original systemPackages that are user applications
    gh
    waybar
    git # User-level git
    ghostty
    rofi-wayland
    kitty
    google-chrome
    vscode
    # firefox # Managed by programs.firefox.enable instead if you prefer that
    # fish # Managed by programs.fish.enable

    direnv
    gawk # For the nvidia stats script

    # Script for NVIDIA Waybar stats
    (pkgs.writeShellScriptBin "get-nvidia-stats" ''
      #!${pkgs.bash}/bin/bash
      # Ensure nvidia-smi and gawk are in PATH or use absolute paths if necessary
      # On NixOS, nvidia-smi should be in PATH if NVIDIA drivers are correctly installed.
      # gawk is added to home.packages.

      UTILIZATION=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | ${pkgs.gawk}/bin/awk '{print $1}')
      MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | ${pkgs.gawk}/bin/awk '{print $1}')
      MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | ${pkgs.gawk}/bin/awk '{print $1}')

      if [ -z "$UTILIZATION" ] || [ -z "$MEM_USED" ] || [ -z "$MEM_TOTAL" ]; then
        # Data couldn't be fetched, output an error or placeholder
        printf '{"text": "N/A", "tooltip": "Failed to fetch NVIDIA stats", "percentage": 0}\n'
        exit 0
      fi

      MEM_USED_GB=$(LC_NUMERIC=C ${pkgs.gawk}/bin/awk -v mem_used="$MEM_USED" 'BEGIN {printf "%.1f", mem_used / 1024}')
      MEM_TOTAL_GB=$(LC_NUMERIC=C ${pkgs.gawk}/bin/awk -v mem_total="$MEM_TOTAL" 'BEGIN {printf "%.1f", mem_total / 1024}')

      TEXT_OUTPUT="GPU: $UTILIZATION% | MEM: ''${MEM_USED_GB}G/''${MEM_TOTAL_GB}G"
      TOOLTIP_TEXT="GPU Utilization: $UTILIZATION%\nMemory Used: $MEM_USED MiB\nMemory Total: $MEM_TOTAL MiB"

      printf '{"text": "%s", "tooltip": "%s", "percentage": %s}\n' "$TEXT_OUTPUT" "$TOOLTIP_TEXT" "$UTILIZATION"
    '')

    # Fonts are now managed system-wide in system/options.nix
    # nerd-fonts.jetbrains-mono
    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # noto-fonts-cjk-sans
    # noto-fonts-emoji

    # Add other user packages here
    # e.g. thunderbird
  ];
}
