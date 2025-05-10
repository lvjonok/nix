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
    ];
    # userSettings = { ... };
  };
}
