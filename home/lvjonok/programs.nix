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
    # extensions = with pkgs.vscode-extensions; [ ... ];
    # userSettings = { ... };
  };
}
