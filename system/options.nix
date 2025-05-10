{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Fish shell system-wide
  # This is required if users have Fish set as their default shell at the system level.
  programs.fish.enable = true;

  # List packages installed in system profile.
  # Most user applications should be in home-manager.
  # Keep this list minimal, for system-wide tools if any.
  environment.systemPackages = with pkgs; [
    git
    # e.g., git if needed for system scripts, otherwise move to home-manager
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05"; # Did you read the comment?
}
