{ pkgs, config, inputs, ... }: # inputs is from home-manager.extraSpecialArgs

{
  imports = [
    ./packages.nix
    ./programs.nix
    ./hyprland.nix
    ./waybar.nix
    # You can add more modules here, e.g., ./git.nix, ./shell.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lvjonok";
  home.homeDirectory = "/home/lvjonok";

  # Nicely reload systemd units when changing configurations.
  systemd.user.startServices = "sd-switch";

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05"; # Set to the version you're currently using
}
