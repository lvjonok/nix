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

    # Add other user packages here
    # e.g. thunderbird
  ];
}
