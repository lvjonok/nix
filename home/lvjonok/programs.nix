{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    # package = pkgs.firefox; # To use a specific version or variant
    # profiles = {
    #   default = {
    #     isDefault = true;
    #     # Add settings, extensions, etc.
    #   };
    # };
  };

  programs.fish = {
    enable = true;
    # plugins = [
    #   { name = "plugin-name"; src = pkgs.fetchFromGitHub { ... }; }
    # ];
    # shellInit = ''
    #   set -x EDITOR "nvim"
    # '';
  };

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true; # If you use Fish shell
    # enableZshIntegration = true; # If you use Zsh
    # enableBashIntegration = true; # If you use Bash
    nix-direnv.enable = true; # Highly recommended for Nix projects
  };

  # Example: Starship prompt for fish (and other shells)
  # programs.starship = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };

  # You can configure other programs here, e.g.:
  programs.git = {
    enable = true;
    userName = "Lev Kozlov";
    userEmail = "kozlov.l.a10@gmail.com";
  };

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium; # If you prefer VSCodium
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      arrterian.nix-env-selector
      ms-vscode-remote.remote-ssh

      # themes
      github.github-vscode-theme
    ];
    userSettings = {
      # Set the editor font family
      # Make sure "JetBrainsMono Nerd Font" is listed.
      # You can add fallbacks if desired.
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontSize" = 12;
      "terminal.integrated.fontSize" = 12;
      "editor.fontLigatures" =
        true; # Enable font ligatures if your font supports them
      # Add any other VS Code settings you want to manage here
      # For example, to set the terminal font:
      "terminal.integrated.fontFamily" =
        "'JetBrainsMono Nerd Font', 'monospace'";

      # Set theme
      "workbench.colorTheme" = "GitHub Light";
      
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland; # Use rofi-wayland
    theme = "Arc";
    terminal = "ghostty";
    # You can add other Rofi settings here if needed
    # For example:
    # extraConfig = {
    #   modi = "drun,run,window";
    #   icon-theme = "Papirus";
    #   show-icons = true;
    # };
  };

  programs.nix-index = {
    enable = true;
    # package = pkgs.nix-index; # If you want to use a specific version
    enableFishIntegration = true; # If you use Fish shell
  };
}
